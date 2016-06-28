(comment
; ===---Hodor level 0 - Clojure----------------------------------------------===
;        Hodor level 0 Project, by Julien Barbier.
;        Solution using Clojure.
;
;        by Alexandro de Oliveira.
; ===------------------------------------------------------------------------===
)
; Loading modules:
(ns hodor0.core
  (:require [net.cgrand.enlive-html :as html] ; => Module for web scraping/DOM manipulation.
            [org.httpkit.client :as http])  ; => Html Module
  (:gen-class))

; Main function:
(defn -main
  [] ; 0 Arguments to main function.
  ;; Setting the request:
  (let [options {:user-agent "Havk64 Clojure http requests"
                :form-params {:id "23" :holdthedoor "submit"}
                :keepalive 30000
                }
        ;; POST request:
        {:keys [status headers body error] :as resp } @(http/post "http://173.246.108.142/level0.php" options)]
    (if error
      (println "Failed" error)
      (println "Voted!" headers))
    (println "Body is:" body))
)
