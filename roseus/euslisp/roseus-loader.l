;; create ROS package and shadow conflicting symbols
(let ((ros-pkg (or (find-package "ROS") (make-package "ROS" :use (list "LISP" "GEOMETRY")))))
  (shadow 'object ros-pkg)
  (shadow 'time ros-pkg))

;; load core file
(load "roseus" :package "ROS")

;; include ros messages packages
(ros::roseus-add-msgs "std_msgs")
(ros::roseus-add-msgs "geometry_msgs")

;; load more files
(load "eustf" :package "ROS")
(load "actionlib" :package "ROS")
(load "roseus-utils")


;; check if this process is created by roslaunch
(when (let ((arg (car (last lisp::*eustop-argument*))))
        (and (>= (length arg) 7) (string= "__log:=" (subseq arg 0 7))))
  (ros::ROS-INFO "install ros::roseus-sigint-handler")
  (setq lisp::*exit-on-fatal-error* t)
  (install-handler error 'ros::roseus-error)
  (install-handler unix::sigint-received 'ros::roseus-sigint-handler)
  (unix:signal unix::sighup 'ros::roseus-sigint-handler)
  (defmacro user::do-until-key (&rest forms) `(while t ,@forms))
  (defun user::y-or-n-p (&rest args) t))
