true; clojure $0 ; exit
(->> (slurp "day10-input.txt")
     clojure.string/split-lines
     (map #(Integer/parseInt %))
     sort
     ((fn [x] (concat [0] x [(+ 3 (apply max x))])))
     (partition 2 1)
     (map #(- (apply - %)))
     frequencies
     vals
     (apply *)
     println
     )

(def count-possibilities #(0))

(defn count-possibilities-raw [previous, [current & remaining]]
  (if (> (count remaining) 0)
    (if (> (- (first remaining) previous) 3)
      (count-possibilities current remaining)
      (+
        (count-possibilities previous remaining)
        (count-possibilities current remaining)
        )
      )
    1
    )
  )
(def count-possibilities (memoize count-possibilities-raw))

(let [joltVals (->> (slurp "day10-input.txt")
                    clojure.string/split-lines
                    (map #(Integer/parseInt %))
                    sort
                    ((fn [x] (concat x [(+ 3 (apply max x))])))
                    )]
  (println (count-possibilities 0 joltVals))
  )
