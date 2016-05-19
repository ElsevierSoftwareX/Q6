! (C) 2016 Paul Bauer, Beer Ware Licence
! math.f90
! by Paul Bauer
! general math functions for vector operations used in the program

module  QMATH

use SIZES
! this is now the default vector type for all operations
TYPE qr_vec
real(kind=prec) :: x,y,z
end type qr_vec

! default distance type that contains squared and normal distance
! for bond operations
TYPE qr_dist
real(kind=prec) :: r,r2
end TYPE qr_dist

! distance type that also contains r6,r12 for vdW
TYPE qr_dist2
real(kind=prec) :: r,r2,r6,r12
end TYPE qr_dist2

real(kind=prec) :: pi, deg2rad, rad2deg

contains

TYPE(qr_vec) function qvec_add(a,b)
! vector addition, std function used later
! args
TYPE(qr_vec) :: a,b
! locals
qvec_add%x = a%x + b%x
qvec_add%y = a%y + b%y
qvec_add%z = a%z + b%z
end function qvec_add

TYPE(qr_vec) function qvec_sub(a,b)
! vector substraction, std function used later
! args
TYPE(qr_vec) :: a,b
! locals
qvec_add%x = a%x - b%x
qvec_add%y = a%y - b%y
qvec_add%z = a%z - b%z
end function qvec_sub

TYPE(qr_dist) function q_dist(a,b)
! returns distance and squared distance
! args
TYPE(qr_vec) :: a,b
! locals
TYPE(qr_vec) :: temp
temp = qvec_sub(b,a)
q_dist%r2 = temp%x**2 + temp%y**2 + temp%z**2
q_dist%r  = q_sqrt(q_dist%r2)
end function q_dist

TYPE(qr_dist2) function q_dist2(a,b)
! returns distance, squared distance and higher orders for vdW
! args
TYPE(qr_vec) :: a,b
! locals
TYPE(qr_vec) :: temp
temp = qvec_sub(b,a)
q_dist2%r2  = temp%x**2 + temp%y**2 + temp%z**2
q_dist2%r   = q_sqrt(q_dist2%r2)
q_dist2%r6  = q_dist2%r2 * q_dist2%r2 * q_dist2%r2
q_dist2%r12 = q_dist2%r6 * q_dist2%r6
end function q_dist2

real(kind=prec) function q_dotprod(a,b)
! returns scalar value of dot product
! implemented the normal fortran dot product
! worked into the new q vector system
! args
TYPE(qr_vec) :: a,b
! locals
! fortran intrinsic return values are not defined, need to calculate by hand
!q_dotprod = dot_product(veca,vecb)
q_dotprod = a%x*b%x + a%y*b%y + a%z*b%z
end function q_dotprod

TYPE(qr_vec) function q_crossprod(a,b)
! returns vector with cross product
! for use with q vector arrays
! args
TYPE(qr_vec) :: a,b
! locals

q_crossprod%x = a%y * b%z - a%z * b%y
q_crossprod%y = a%z * b%x - a%x * b%z
q_crossprod%z = a%x * b%y - a%y * b%x

end function q_crossprod

real(kind=prec) function q_logarithm(a)
! returns results of dlog as real of chosen precision type
! to make compilation independent of variable size
! args
real(kind=prec) :: a
! locals
real(kind=doubleprec) :: temp1,temp2

temp1       = a
temp2       = dlog(temp1)
q_loagrithm = temp2

end function q_logarithm

real(kind=prec) function q_sqrt(a)
! returns result of dsqrt as real of chosen precision type
! to make compilation independent of variable size
! args
real(kind=prec) :: a
! locals
real(kind=doubleprec) :: temp1,temp2

temp1  = a
temp2  = dsqrt(temp1)
q_sqrt = temp2

end function q_sqrt

real(kind=prec) function q_atan(a)
! returns results of datan as real of chosen precision type
! to make compilation independent of variable size
! args
real(kind=prec) :: a
! locals
real(kind=doubleprec) :: temp1,temp2

temp1  = a
temp2  = datan(temp1)
q_atan = temp2

end function q_atan

real(kind=prec) function q_acos(a)
! returns results of dacos as real of chosen precision type
! to make compilation independent of variable size
! args
real(kind=prec) :: a
! locals
real(kind=doubleprec) :: temp1,temp2

temp1  = a
temp2  = dacos(temp1)
q_atan = temp2

end function q_acos

real(kind=prec) function q_cos(a)
! returns results of dcos as real of chosen precision type
! to make compilation independent of variable size
! args
real(kind=prec) :: a
! locals
real(kind=doubleprec) :: temp1,temp2

temp1  = a
temp2  = dcos(temp1)
q_atan = temp2

end function q_cos

real(kind=prec) function q_sin(a)
! returns results of dsin as real of chosen precision type
! to make compilation independent of variable size
! args
real(kind=prec) :: a
! locals
real(kind=doubleprec) :: temp1,temp2

temp1  = a
temp2  = dsin(temp1)
q_atan = temp2

end function q_sin


subroutine math_initialize
        pi = 4.0_prec*q_atan(one)
        deg2rad = pi/180.0_prec
        rad2deg = 180.0_prec/pi
end subroutine math_initialize

end module QMATH

