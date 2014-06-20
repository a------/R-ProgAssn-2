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
