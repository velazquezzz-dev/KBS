(defrule classifyDisease
  =>
  (printout t "Do you have respiratory problems? (yes/no): " crlf)
  (bind ?respiratory (read))
  (if (eq ?respiratory "yes") then
      (printout t "The disease is Asthma." crlf)
  else
      (printout t "Do you have inflammatory problems? (yes/no): " crlf)
      (bind ?inflammatory (read))
      (if (eq ?inflammatory "yes") then
          (printout t "Do you have a Fever? (yes/no): " crlf)
          (bind ?fever (read))
          (if (eq ?fever "yes") then
              (printout t "The disease is Lupus." crlf)
          else
              (printout t "Do you have Fatigue? (yes/no): " crlf)
              (bind ?fatigue (read))
              (if (eq ?fatigue "yes") then
                  (printout t "Do you have Weakness? (yes/no): " crlf)
                  (bind ?weakness (read))
                  (if (eq ?weakness "yes") then
                      (printout t "The disease is Arthritis." crlf)
                  else
                      (printout t "The disease is Lupus." crlf)
                  )
              )
          )
      else
          (printout t "Do you have nausea? (yes/no): " crlf)
          (bind ?nausea (read))
          (if (eq ?nausea "yes") then
              (printout t "The disease is Migraine." crlf)
          else 
              (printout t "Do you have weakness? (yes/no): " crlf)
              (bind ?weakness2 (read))
              (if (eq ?weakness2 "yes") then
                  (printout t "Do you have limited mobility? (yes/no): " crlf)
                  (bind ?mobility (read))
                  (if (eq ?mobility "yes") then
                      (printout t "The disease is Osteoporosis." crlf)
                  else 
                      (printout t "The disease is Anemia." crlf)
                  )
              )
          )
      )
  )
)

(run)
