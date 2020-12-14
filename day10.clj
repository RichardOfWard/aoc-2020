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