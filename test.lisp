(cl:in-package "https://github.com/g000001/srfi-98#internals")

(5am:def-suite srfi-98)

(5am:in-suite srfi-98)

(5am:test get-environment-variable
  (5am:is (string=
           (string-right-trim "/"
                              (namestring (user-homedir-pathname)))
           (string-right-trim "/"
                              (get-environment-variable "HOME")))))


(5am:test |(setf get-environment-variable)|
  (let ((env-name (labels ((uniq-env ()
                             (let ((name (string (gensym))))
                               (if (get-environment-variable name)
                                   (uniq-env)
                                   name))))
                    (uniq-env))))
    (unwind-protect
         (progn
           (setf (get-environment-variable env-name) env-name)
           ;;
           (5am:is (string= (get-environment-variable env-name)
                            env-name))
           ;;
           )
      #+allegro (excl.osi:unsetenv env-name)
      #+sbcl (sb-posix:unsetenv env-name)
      #+lispworks (osicat-posix:unsetenv env-name)
      )))

(5am:test |GET-ENVIRONMENT-VARIABLES vs GET-ENVIRONMENT-VARIABLE|
  (let ((envs (get-environment-variables)))
    (5am:is (equal envs
                   (mapcar (lambda (e &aux (name (car e)))
                             (cons name
                                   (get-environment-variable name)))
                           envs)))))
