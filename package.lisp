;;;; package.lisp

(cl:in-package :cl-user)

(defpackage :srfi-98
  (:use)
  (:export :get-environment-variable
           :get-environment-variables))

(defpackage :srfi-98-internal
  (:use :srfi-98 :cl :fiveam))

