# Calling sequence:
# let G be an invertible matrix.
# > G <- [some matrix]
# 
# For a nontrivial example:
# > G <- matrix(rnorm(4000^2, 10), 4000, 4000)
#
# Create the cached matrix list
# > m <- makeCacheMatrix()
#
# Set the matrix G as the cached matrix in the list with the 'set' tag
# > m$set(G)
#
# Return the matrix to check if it has been stored properly
# > m$get()
#
# Solve the matrix with cacheSolve. cacheSolve's argument is the
# cached matrix list m. The output is G^-1.
# cacheSolve cannot be used without saving the cached list 'm' first.
# > cacheSolve(m)
#
# if solved again (and the value of G hasn't changed), it will simply
# return the cached value of the inverse instead of performing the
# computation again. 

makeCacheMatrix <- function(x = numeric() ) {
      
      #'set' tag brings a numeric (matrix) into the list
      #and the double arrow assignment allows the environment
      #outside the current one (this function) to use the variable
      m <- NULL
      set <- function(y) {
            x <<- y
            m <<- NULL
      }
      
      #'get' allows you to recall the value of the numeric in the list
      get <- function() x
      
      #setinverse and getinverse, respectively, solve the matrix
      #problem (caching it) and retrieving the cached solution
      setinverse <- function(solve) m <<- solve
      getinverse <- function() m
      
      #return the list of variables/tags which are essentially, pointers.
      list(set = set, get = get,
           setinverse = setinverse,
           getinverse = getinverse)
}

#cacheSolve is called with the list of cached matrices as its argument.
cacheSolve <- function(x, ...) {
      m <- x$getinverse()
      
      #if m is null, then this won't happen. The inverse hasn't been computed.
      #if the inverse has been computed, then m won't be null and the message
      #will print to the console.
      if(!is.null(m)) {
            message("getting cached data instead of recomputing")
            return(m)
      }
      #store the matrix from makeCacheMatrix's get function
      data <- x$get()
      #actually perform the work of the matrix inversion
      m <- solve(data, ...)
      #set the inverse in the 3rd item of the makeCacheMatrix list
      x$setinverse(m)
      #return the inverse
      m
}