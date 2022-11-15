(use-modules
 (guix)
 (guix git-download)
 (guix profiles)
 (gnu packages admin)
 (gnu packages base)
 (gnu packages cmake)
 (gnu packages commencement)
 (gnu packages embedded)
 (gnu packages terminals))
 
(define-public xfel-1.2.9
  (package
   (inherit xfel)
   (version "1.2.9")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/xboot/xfel.git")
           (commit (string-append "v" version))))
     (sha256
      (base32 "0gs37w5zjfmyadm49hdalq6vr6gidc683agz3shncgj93x2hxx02"))))
   (arguments
    `(#:tests? #f ; No tests exist
      #:phases
      (modify-phases
       %standard-phases
       (add-after 'unpack 'patch-installation-target
		  (lambda* (#:key outputs #:allow-other-keys)
		    (let ((out (assoc-ref outputs "out")))
		      (substitute* "Makefile"
				   (("/usr/local") out)
				   (("/usr") out)
				   (("/etc/udev/rules.d")
				    (string-append out "/lib/udev/rules.d"))
				   (("udevadm control --reload") ""))))) ; a pice of shit, clean it.
       (delete 'configure))))))

(packages->manifest
 (list
  xfel-1.2.9
  cmake
  gnu-make
  gcc-toolchain-7
  arm-none-eabi-nano-toolchain-7-2018-q2-update
  gdb-arm-none-eabi
  picocom))
