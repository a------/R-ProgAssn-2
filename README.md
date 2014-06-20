## Project 2- Peer Assessment:  Lexical Scoping-
#  Abraham Hmiel, June 20th 2014
#  Introduction to R Programming

 Calling sequence:
 let G be an invertible matrix.
 > G <- [some matrix]
 
 For a nontrivial example:
 > G <- matrix(rnorm(4000^2, 10), 4000, 4000)

 Create the cached matrix list
 > m <- makeCacheMatrix()

 Set the matrix G as the cached matrix in the list with the 'set' tag
 > m$set(G)

 Return the matrix to check if it has been stored properly
 > m$get()

 Solve the matrix with cacheSolve. cacheSolve's argument is the
 cached matrix list m. The output is G^-1.
 cacheSolve cannot be used without saving the cached list 'm' first.
 > cacheSolve(m)

 if solved again (and the value of G hasn't changed), it will simply
 return the cached value of the inverse instead of performing the
 computation again. 
