;; create ROS package and shadow conflicting symbols
(let ((ros-pkg (or (find-package "ROS") (make-package "ROS"))))
  (shadow 'object ros-pkg)
  (shadow 'time ros-pkg))

;; load files
(load "roseus" :package "ROS")
(load "eustf" :package "ROS")
(load "actionlib" :package "ROS")
(load "roseus-utils")

;; check if this process is created by roslaunch
(when (let ((arg (car (last lisp::*eustop-argument*))))
        (and (>= (length arg) 7) (string= "__log:=" (subseq arg 0 7))))
  (ros::ROS-INFO "install ros::roseus-sigint-handler")
  (setq lisp::*exit-on-fatal-error* t)
  (lisp::install-handler error 'ros::roseus-error)
  (lisp::install-handler unix::sigint-received 'ros::roseus-sigint-handler)
  (unix:signal unix::sighup 'ros::roseus-sigint-handler)
  (defmacro user::do-until-key (&rest forms) `(while t ,@forms))
  (defun user::y-or-n-p (&rest args) t))
