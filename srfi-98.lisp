;;;; srfi-98.lisp

(cl:in-package :srfi-98-internal)

(def-suite srfi-98)

(in-suite srfi-98)

(defun get-environment-variable (name)
  #+allegro (excl.osi:getenv name))

(test get-environment-variable
  (is (string= (string-right-trim "/"
                                  (namestring (user-homedir-pathname)))
               (string-right-trim "/"
                                  (get-environment-variable "HOME")))))

(defun get-environment-variables ()
  #+allegro (excl.osi:environment))

(defun (setf get-environment-variable) (val name)
  #+allegro (setf (excl.osi:getenv name) val))

(test |(setf get-environment-variable)|
  (let ((env-name (labels ((uniq-env ()
                             (let ((name (string (gensym))))
                               (if (get-environment-variable name)
                                   (uniq-env)
                                   name))))
                    (uniq-env))))
    (unwind-protect (progn
                      (setf (get-environment-variable env-name) env-name)
                      ;;
                      (is (string= (get-environment-variable env-name)
                                   env-name))
                      ;;
                      )
      #+allegro (excl.osi:unsetenv env-name)
      )))































