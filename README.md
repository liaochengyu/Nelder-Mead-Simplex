# Nelder-Mead-Simplex
Nelder-Mead Simplex Algorithm

## What does it do?

The Nelder-Mead algorithm, sometimes also called downhill simplex method, was originally published in 1965. It is an iterative algorithm for local, unconstrained minimisation of a non-linear function `f : R^n --> R`. In contrast to most other iterative algorithms, it does not rely on the derivative of the target function but only evaluates the function itself. This makes it extremely well suited for cases when the target function is not an algebraic term, but a simulation model which cannot be derived directly. It also does not approximate the function’s gradient but is based on geometrical projections of an n+1-point polygon — the simplex — in the n-dimensional parameter space of the target function. A simplex in two dimensions is a triangle, one in three dimensions is a tetrahedron. In general, the simplex can be represented as a matrix S \in R^{n×n+1} of its points:

    S = [x_0 ... x_N]  with each x_i \in R^n

The basic idea behind the simplex algorithm is that the worst point of `S`is replaced by a better one with a smaller function value and to repeat this operation iteratively until a local optimum has been found. To achieve this, three different transformations are applied to the simplex which let it move in directions of descent and shrink around a local minimum. These transformations are called reflection, expansion and contraction.

In each iteration, first the worst point is reflected at the centroid of the remaining points. Depending on the quality (good or bad) it then replaces the worst point in the simplex. If the reflected point is not better, it is withdrawn and the other fallback operations are executed.

The globalized Nelder-Mead method just generalizes this idea to find a global minimum. Instead of initialising the simplex once, multiple simplices are initialised and each one finds one local minimum. There are some tweaks to make the location of these simplices better than random, but principally they are spread randomly within the allowed boundaries.

## Usage

The function itself has the following signature:

    [x,fval,flag,time,object_value]=NMS(fun,x0,max_time,eps)
    
### Arguments

    fun        A handle of the function to be minimized
	x0         starting point
	max_time   the max number of iteration ,the default value is 10000
	eps         accuracy, the default value is 1e-5
### Return values

	x					target point
	fval				minimal value
	flag				indicator of the algorithm is successful or not
	time				the max number of iteration when the program break
	object_value		matrix which include minimal value in the each iteration

## Visulization
![](https://raw.githubusercontent.com/liaochengyu/Nelder-Mead-Simplex/master/Nelder-Mead%20Simplex/img/result.png)