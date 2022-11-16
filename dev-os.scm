(use-modules (gnu))

(load "./dev-pkg.scm")

(use-service-modules networking ssh)

(define-public sunxi-dev-os
  (operating-system
    (host-name "sunxi-dev")
    (timezone "UTC")
    (locale "en_US.utf8")

    (bootloader (bootloader-configuration
                  (bootloader grub-bootloader)
                  (targets '("/dev/sdX"))))
    (file-systems (cons* (file-system
                           (device (file-system-label "sunxi-dev-rootfs"))
                           (mount-point "/")
                           (type "ext4")) %base-file-systems))

    (users (cons (user-account
                   (name "sunxidev")
                   (comment "sunxi develop")
                   (group "users")
                   (supplementary-groups '("wheel" "dialout" "audio" "video")))
                 %base-user-accounts))

    (packages (append %sunxi-dev-packages %base-packages))

    (services
     (append (list (service dhcp-client-service-type)
                   (service openssh-service-type)) %base-services))))

sunxi-dev-os
