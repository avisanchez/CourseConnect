//
//  PostService.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/30/22.
//

import Firebase
import UIKit

struct PostService {
        
    func uploadPost(category: String, course: String, title: String, body: String, completion: @escaping(Bool) -> Void) {
            
        guard let uid = Auth.auth().currentUser?.uid else { return }
    
        let data = ["category": category,
                    "course": course,
                    "uid": uid,
                    "title": title,
                    "body": body,
                    "likes": 0,
                    "reports": 0,
                    "timestamp": Timestamp(date: Date())] as [String: Any]
        
        
        
        var ref: DocumentReference? = nil
        
        // upload data to 'posts' collection
        ref = Firestore.firestore().collection("posts").addDocument(data: data, completion: { error in
            if let error = error {
                print("DEBUG: Failed to upload tweet with error: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            completion(true)
            print("DEBUG: Did upload post...")
        })
        
        // create reference to post in user collection
        guard let documentID = ref?.documentID else { return }
        
        let referenceData: [String: Any] = ["category" : category, "course": course]
        
        
        Firestore.firestore().collection("users").document(uid).collection("user-posts").document(documentID)
            .setData(referenceData) { _ in
                print("DEBUG: Did create post pointer in user")
            }
        
    }
    
    func uploadPost(category: String, course: String, title: String, images: [UIImage], completion: @escaping(Bool) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
                
        let data = ["category": category,
                    "course": course,
                    "uid": uid,
                    "title": title,
                    "imageFolderUrl": "",
                    "likes": 0,
                    "reports": 0,
                    "timestamp": Timestamp(date: Date())] as [String: Any]
        
        var ref: DocumentReference? = nil
        
        // upload data to 'posts' collection
        ref = Firestore.firestore().collection("posts").addDocument(data: data, completion: { error in
            if let error = error {
                print("DEBUG: Failed to upload tweet with error: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            // create reference to post in user collection
            guard let documentID = ref?.documentID else { return }
            
            ImageUploader.uploadImage(forPostID: documentID, withImages: images)
            
            completion(true)
            print("DEBUG: Did upload post...")
        })
        
        
        
    }
    
    
    
    func fetchPosts(withFilter filter: String, expectedValue value: String, completion: @escaping([Post]) -> Void) {
        
        // fetch post with single filter - check for equivalence
        Firestore.firestore().collection("posts").whereField(filter, isEqualTo: value).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            let posts = documents.compactMap({ try? $0.data(as: Post.self)})
            completion(posts)
        }
    }
    
    func fetchPosts(completion: @escaping([Post]) -> Void) {
        Firestore.firestore().collection("posts")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let posts = documents.compactMap({ try? $0.data(as: Post.self) })
                completion(posts)
            }
    }
    
    func fetchPosts(forUid uid: String, completion: @escaping([Post]) -> Void) {
        Firestore.firestore().collection("posts")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let posts = documents.compactMap({try? $0.data(as: Post.self)} )
                completion(posts.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
            }
    }
    
    func likePost(_ post: Post, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let postID = post.id else { return }
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("posts").document(postID)
            .updateData(["likes": post.likes + 1]) { _ in
                userLikesRef.document(postID).setData([:]) { _ in
                    completion()
                }
            }
        print("DEBUG Like post here...")
    }
    
    func unlikePost(_ post: Post, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let postID = post.id else { return }
        guard post.likes > 0 else { return }
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")

        
        Firestore.firestore().collection("posts").document(postID)
            .updateData(["likes": post.likes - 1]) { _ in
                userLikesRef.document(postID).delete() { _ in
                    completion()
                }
            }
    }
    
    func checkIfUserLikedPost(_ post: Post, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let postID = post.id else { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .document(postID).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
    
    func fetchLikedPosts(forUid uid: String, completion: @escaping([Post]) -> Void) {
        var posts = [Post]()
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                documents.forEach { doc in
                    let postID = doc.documentID
                    
                    Firestore.firestore().collection("posts")
                        .document(postID)
                        .getDocument { snapshot, _ in
                            guard let post = try? snapshot?.data(as: Post.self) else { return }
                            posts.append(post)
                            
                            completion(posts)
                        }
                }
            }
    }
    
    func deletePost(post: Post) {
    
        // delete post from post collection
        
        guard let postID = post.id else { return }
        
        Firestore.firestore().collection("posts").document(postID).delete { error in
            if let error = error {
                print("DEBUG: error deleting from posts collectio:  \(error.localizedDescription)")
            }
        }
        
        
        // delete post from user collection
        
        let userID = post.uid
        
        Firestore.firestore().collection("users").document(userID).collection("posts").document(postID).delete { error in
            if let error = error {
                print("DEBUG: error deleting from user collection: \(error.localizedDescription)")
            }
        }
        
    }
    
    func uploadComment(underPost post: Post, content: String, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let postID = post.id else { return }
        
        let data = ["uid": uid,
                    "pid": postID,
                    "content": content,
                    "reports": 0,
                    "timestamp": Timestamp(date: Date())] as [String: Any]
        
        Firestore.firestore().collection("comments").addDocument(data: data, completion: { error in
            if let error = error {
                print("DEBUG: Failed to upload comment with error: \(error.localizedDescription)")
                completion(false)
                return
            }
            completion(true)
            print("DEBUG: Did upload comment...")
        })
        
    }
    
    func fetchComments(forPost post: Post, completion: @escaping([Comment]) -> Void) {
        Firestore.firestore().collection("comments")
            .whereField("pid", isEqualTo: post.id)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let comments = documents.compactMap({try? $0.data(as: Comment.self)} )
                completion(comments.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
            }
    }
    

}
