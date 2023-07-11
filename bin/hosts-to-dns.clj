#!/usr/bin/env bb
(require '[babashka.curl :as curl])
(import (java.io File))

;; todo: remove domain name that have localhost

;; (def dns-content
;;   (filter #(not (nil? %1))
;;           (map
;;                                         ;(fn [line] (first (println (str/split line #" "))))
;;             #(str (second (str/split %1 #" ")) "\n")
;;             (str/split (slurp "/home/moh/Documents/dns.log") #"\n"))))

;; (def bookmarks
;;   (map #(str %1 "\n")
;;        (str/split
;;          (slurp "/home/moh/Documents/bookmarks_1_4_23.html" ) #"\n" )))

;; (def dns-content
;;   (map #(str/replace %1 #"#" "") dns-content) )

;; (def dns-content
;;   (map #(str/replace %1 #"www.192.168.1.2.com" "") dns-content))

;; (def dns-content
;;   (filter #(not (str/starts-with? %1 "192.168")) dns-content ))

;; ;; (def dns-content
;; ;; (filter #(str/starts-with? %1 "localhost") dns-content ))
;; ;; (println dns-content)

;; (def bookmarks
;;   (filter #(not (str/starts-with? %1 "192.168")) bookmarks ))

;; (def bookmarks
;;   (filter #(not (str/starts-with? %1 "192.168")) bookmarks ))

;; (def bookmarks
;;   (map #(str/replace %1 #"file:.*" "") bookmarks))

;;                                         ; (println bookmarks)


;; (def uniq-addr
;;   (into []
;;         (map str/trim (set  (into [] (concat dns-content bookmarks))))))


;; (def commands (str/join
;;                 "\n"
;;                 (map
;;                   (fn [line]
;;                     (def l (str/replace line #"\n" ""))
;;                     (str "echo `dig +short " l " | tail -n 1` " l )
;;                     )
;;                   uniq-addr)))

;; (println commands)
;; (spit  "/tmp/dns.sh" "#!/bin/bash\n")

;; (spit "/tmp/dns.sh" commands)
                                        ; (print  (set (vector bookmarks)))

(defn main[]
  (let [line (slurp *in*)]
    (doseq [s (str/split line #"\n")]
      ;; (println s)
      (println
                (str "echo `dig +short " s " | tail -n 1` " s ))
      )))
;; sample usage
;; cat logfile | awk '{print $5}' | sort | uniq | cut -d'/' -f1 | cut -d':' -f1 | sort | uniq | filter-domain | hosts-to-dns.clj | hosts-to-dns.clj  > dns.sh
(main)


