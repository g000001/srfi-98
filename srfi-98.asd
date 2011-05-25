;;;; srfi-98.asd

(cl:in-package :asdf)

(defsystem :srfi-98
  :serial t
  :components ((:file "package")
               (:file "srfi-98")))

(defmethod perform ((o test-op) (c (eql (find-system :srfi-98))))
  (load-system :srfi-98)
  (or (flet ((_ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
         (let ((result (funcall (_ :fiveam :run) (_ :srfi-98-internal :srfi-98))))
           (funcall (_ :fiveam :explain!) result)
           (funcall (_ :fiveam :results-status) result)))
      (error "test-op failed") ))

