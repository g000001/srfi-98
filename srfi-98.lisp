;;;; srfi-98.lisp

(cl:in-package :srfi-98-internal)

(def-suite srfi-98)

(in-suite srfi-98)

(defun get-environment-variable (name)
  #+allegro (excl.osi:getenv name)
  #+sbcl (sb-posix:getenv name))

(test get-environment-variable
  (is (string= (string-right-trim "/"
                                  (namestring (user-homedir-pathname)))
               (string-right-trim "/"
                                  (get-environment-variable "HOME")))))

(defun get-environment-variables ()
  #+allegro (excl.osi:environment)
  #+sbcl (mapcar (lambda (env)
                   (let ((pos (position #\= env
                                        :from-end 'T)))
                     (cons (subseq env 0 pos)
                           (subseq env (1+ pos)))))
                 (sb-ext:posix-environ)))

(defun (setf get-environment-variable) (val name)
  #+allegro (setf (excl.osi:getenv name) val)
  #+sbcl (sb-posix:setenv name val 1)) ;t => 1, nil => 0

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

(test |GET-ENVIRONMENT-VARIABLES vs GET-ENVIRONMENT-VARIABLE|
  (let ((envs (get-environment-variables)))
    (is (equal envs
               (mapcar (lambda (e &aux (name (car e)))
                         (cons name
                               (get-environment-variable name)))
                       envs)))))

































