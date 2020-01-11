;;;; srfi-98.asd

(cl:in-package :asdf)

(defsystem :srfi-98
  :version "20200108"
  :description "SRFI 98: get-environment-variable"
  :long-description "SRFI 98: An interface to access environment variables."
  :author "CHIBA Masaomi"
  :maintainer "CHIBA Masaomi"
  :license "Unlicense"
  :serial t
  :depends-on (#+lispworks :osicat #+sbcl :sb-posix)
  :components ((:file "package")
               (:file "srfi-98")))

(defmethod perform :after ((o load-op) (c (eql (find-system :srfi-98))))
  (let ((name "https://github.com/g000001/srfi-98")
        (nickname :srfi-98))
    (if (and (find-package nickname)
             (not (eq (find-package nickname)
                      (find-package name))))
        (warn "~A: A package with name ~A already exists." name nickname)
        (rename-package name name `(,nickname)))))

(defsystem :srfi-98.test
  :version "20200108"
  :description "SRFI 98: get-environment-variable"
  :long-description "SRFI 98: An interface to access environment variables."
  :author "CHIBA Masaomi"
  :maintainer "CHIBA Masaomi"
  :license "Unlicense"
  :serial t
  :depends-on (:srfi-98 :fiveam)
  :components ((:file "test")))

(defmethod perform ((o test-op) (c (eql (find-system :srfi-98.test))))
  (or (flet ((_ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
        (let ((result
               (funcall (_ :fiveam :run)
                        (_ "https://github.com/g000001/srfi-98#internals"
                           :srfi-98))))
          (funcall (_ :fiveam :explain!) result)
          (funcall (_ :fiveam :results-status) result)))
      (error "test-op failed") ))
