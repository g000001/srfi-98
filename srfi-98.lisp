;;;; srfi-98.lisp

(cl:in-package "https://github.com/g000001/srfi-98#internals")

(defun get-environment-variable (name)
  #+allegro (excl.osi:getenv name)
  #+sbcl (sb-posix:getenv name)
  #+lispworks (hcl:getenv name))

(defun get-environment-variables ()
  #+allegro
  (excl.osi:environment)
  #+sbcl
  (mapcar (lambda (env)
            (let ((pos (position #\= env)))
              (cons (subseq env 0 pos)
                    (subseq env (1+ pos)))))
          (sb-ext:posix-environ))
  #+lispworks
  (osicat:environment))

(defun (setf get-environment-variable) (val name)
  #+allegro (setf (excl.osi:getenv name) val)
  #+sbcl (sb-posix:setenv name val 1)   ;t => 1, nil => 0
  #+lispworks (hcl:setenv name val))
