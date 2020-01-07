;;;; package.lisp

(cl:in-package :cl-user)

(defpackage "https://github.com/g000001/srfi-98"
  (:use)
  (:export get-environment-variable
           get-environment-variables))

(defpackage "https://github.com/g000001/srfi-98#internals"
  (:use "https://github.com/g000001/srfi-98" cl))

