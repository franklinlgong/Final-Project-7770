extensions [
vid
]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                        ;;;
;;;  Copyright 2017 Jeffrey Pfaffmann and Elaine Reynolds                  ;;;
;;;                                                                        ;;;
;;;  This program is free software: you can redistribute it and/or modify  ;;;
;;;  it under the terms of the GNU General Public License as published by  ;;;
;;;  the Free Software Foundation, either version 3 of the License, or     ;;;
;;;  (at your option) any later version.                                   ;;;
;;;                                                                        ;;;
;;;  This program is distributed in the hope that it will be useful,       ;;;
;;;  but WITHOUT ANY WARRANTY; without even the implied warranty of        ;;;
;;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         ;;;
;;;  GNU General Public License for more details.                          ;;;
;;;                                                                        ;;;
;;;  You should have received a copy of the GNU General Public License     ;;;
;;;  along with this program.  If not, see http://www.gnu.org/licenses/    ;;;
;;;                                                                        ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

globals [

  ;;;; Used to determine the border around the cell sheet.
  ;;;; Thus these are cosmetic and to not contribute to simulation.

  diameter                 ;;;; diameter of the cell
  lipid-distance           ;;;; distance between lipids on the membrane

  GFP-delta-transcription-rate
  CD19-delta-transcription-rate
  BFP-transcription-rate

  anti-GFP-notch-transcription-rate
  anti-CD19-notch-transcription-rate

  acceptions
  rejections

  Ecadherin-transcription-rate

  unitMove                 ;;;;; computed move on radius

  Ecadherin-Interactions
  temp-count
  all-cells

  radius
  radiusFraction
  lipid-density
  notch-cleaved-diffusion-time-signal
  cell-row-cnt
  cell-col-cnt
  centersomeSize
  deltaAge
  notchAge

]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; create breeds ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;=====================================================================
;; the central nucleus

breed [receiver-nucleus-breed    receiver-nucleus]

receiver-nucleus-breed-own [

  lipid-set    ;-- set of lipids owned by nucleus
  lipid-start  ;-- first id in range of lipid names
  lipid-end    ;-- last id in range of lipid names

  cleaved-nuc-anti-CD19-notch-count-value
  cleaved-nuc-anti-GFP-notch-count-value

  roset-neighbors
  currentNuclearNotchCnt
  placed
]
;;=====================================================================

;;=====================================================================
;; the central nucleus
breed [sender-nucleus-breed    sender-nucleus]

sender-nucleus-breed-own [

  lipid-set    ;-- set of lipids owned by nucleus
  lipid-start  ;-- first id in range of lipid names
  lipid-end    ;-- last id in range of lipid names

  roset-neighbors
  currentNuclearNotchCnt
  placed
]
;;=====================================================================

;;=====================================================================
;; the proteins that compose the membrane

breed [lipid-breed lipid]

lipid-breed-own [

  parent     ;-- owning nucleus
  parent-who ;-- owning nucleus id

  left-mem  ;-- lipid to left
  right-mem ;-- lipid to right

  curr-proteins ;-- membrane proteins currently stored at that region
  border-region ;-- the lipids in the neighboring cell region
]
;;=====================================================================

;;=====================================================================
;; Ecadherin transporting through cytosol
breed [Ecadherin-delta-breed       Ecadherin-delta]

Ecadherin-delta-breed-own [
  birth      ;-- the tick that the delta was created
  parent     ;-- owning nucleus
  parent-who ;-- owning nucleus id
  mem-time   ;-- the time delta became a membrane.
]
;;=====================================================================

;;=====================================================================
;; BFP
breed [BFP-delta-breed       BFP-delta]

BFP-delta-breed-own [
  birth      ;-- the tick that the delta was created
  parent     ;-- owning nucleus
  parent-who ;-- owning nucleus id
  mem-time   ;-- the time delta became a membrane.
]
;;=====================================================================

;;=====================================================================
;; recently transcribed CD19-delta transporting to membrane

breed [CD19-delta-breed       CD19-delta]

CD19-delta-breed-own [
  birth      ;-- the tick that the delta was created
  parent     ;-- owning nucleus
  parent-who ;-- owning nucleus id
  mem-time   ;-- the time delta became a membrane.
]
;;=====================================================================

;;=====================================================================
;; recently transcribed GFP delta transporting to membrane

breed [GFP-delta-breed       GFP-delta]

GFP-delta-breed-own [
  birth      ;-- the tick that the delta was created
  parent     ;-- owning nucleus
  parent-who ;-- owning nucleus id
  mem-time   ;-- the time delta became a membrane.
]
;;=====================================================================

;;=====================================================================
;; the Ecadherin diffusing on the membrane

breed [Ecadherin-delta-mem-breed   Ecadherin-delta-mem]

Ecadherin-delta-mem-breed-own [
  birth       ;-- the tick that the original delta was created
  local-lipid ;-- the lipid that the membrane delta is associated with
  parent      ;-- owning nucleus
  parent-who  ;-- owning nucleus id
  mem-time    ;-- the time delta became a membrane.
]
;;=====================================================================

;;=====================================================================
;; the CD19-delta diffusing on the membrane

breed [CD19-delta-mem-breed   CD19-delta-mem]

CD19-delta-mem-breed-own [
  birth       ;-- the tick that the original delta was created
  local-lipid ;-- the lipid that the membrane delta is associated with
  parent      ;-- owning nucleus
  parent-who  ;-- owning nucleus id
  mem-time    ;-- the time delta became a membrane.
]
;;=====================================================================

;;=====================================================================
;; the GFP delta diffusing on the membrane

breed [GFP-delta-mem-breed   GFP-delta-mem]

GFP-delta-mem-breed-own [
  birth       ;-- the tick that the original delta was created
  local-lipid ;-- the lipid that the membrane delta is associated with
  parent      ;-- owning nucleus
  parent-who  ;-- owning nucleus id
  mem-time    ;-- the time delta became a membrane.
]
;;====================================================================


;;=====================================================================
;; the BFP delta diffusing on the membrane

breed [BFP-delta-mem-breed   BFP-delta-mem]

BFP-delta-mem-breed-own [
  birth       ;-- the tick that the original delta was created
  local-lipid ;-- the lipid that the membrane delta is associated with
  parent      ;-- owning nucleus
  parent-who  ;-- owning nucleus id
  mem-time    ;-- the time delta became a membrane.
]
;;====================================================================

;;=====================================================================
;; the CD19-delta diffusing on the membrane in active form

breed [CD19-delta-mem-prime-breed   CD19-delta-mem-prime]

CD19-delta-mem-prime-breed-own [
  birth       ;-- the tick that the original delta was created
  local-lipid ;-- the lipid that the membrane delta prime is associated with
  parent      ;-- owning nucleus
  parent-who  ;-- owning nucleus id
  mem-time    ;-- the time delta became a membrane.
]
;;=====================================================================

;;=====================================================================
;; the GFP delta diffusing on the membrane in active form

breed [GFP-delta-mem-prime-breed   GFP-delta-mem-prime]

GFP-delta-mem-prime-breed-own [
  birth       ;-- the tick that the original delta was created
  local-lipid ;-- the lipid that the membrane delta prime is associated with
  parent      ;-- owning nucleus
  parent-who  ;-- owning nucleus id
  mem-time    ;-- the time delta became a membrane.
]
;;=====================================================================



;;=====================================================================
;; recently transcribed anti-GFP notch transporting to membrane

breed [anti-GFP-notch-breed      anti-GFP-notch]

anti-GFP-notch-breed-own [
  birth      ;-- the tick that the notch was created
  parent     ;-- owning nucleus
  parent-who ;-- owning nucleus id
]
;;=====================================================================


;;=====================================================================
;; anti-GFP-notch that is diffusing on membrane

breed [anti-GFP-notch-mem-breed  anti-GFP-notch-mem]

anti-GFP-notch-mem-breed-own [
  birth       ;-- the tick that the original notch was created
  parent      ;-- owning nucleus
  parent-who  ;-- owning nucleus id
  local-lipid ;-- the lipid that the membrane notch is associated with
  protected
]
;;=====================================================================


;;=====================================================================
;; diffusing cleaved anti-GFP-notch

breed [anti-GFP-cleaved-notch-breed  anti-GFP-cleaved-notch]

anti-GFP-cleaved-notch-breed-own [
  birth       ;-- the tick that the original notch was created
  parent      ;-- owning nucleus
  parent-who  ;-- owning nucleus id
  time-cleaved;-- time the protein was cleaved and sent to nucleus
  indCleavedDiffTime
]
;;=====================================================================


;;=====================================================================
;; cleaved anti-GFP-notch that has reached nucleus and modulating transcription

breed [anti-GFP-notch-nuc-breed  anti-GFP-nucleus-notch]

anti-GFP-notch-nuc-breed-own [
  birth       ;-- the tick that the original notch was created
  parent      ;-- owning nucleus
  parent-who  ;-- owning nucleus id
  time-cleaved;-- time the protein was cleaved and sent to nucleus
  indCleavedDiffTime
  time-nuc    ;-- time the protein was cleaved and sent to nucleus
]
;;=====================================================================

;;=====================================================================
;; recently transcribed anti-CD19-notch transporting to membrane

breed [anti-CD19-notch-breed      anti-CD19-notch]

anti-CD19-notch-breed-own [
  birth      ;-- the tick that the notch was created
  parent     ;-- owning nucleus
  parent-who ;-- owning nucleus id
]
;;=====================================================================


;;=====================================================================
;; anti-CD19-notch that is diffusing on membrane

breed [anti-CD19-notch-mem-breed  anti-CD19-notch-mem]

anti-CD19-notch-mem-breed-own [
  birth       ;-- the tick that the original notch was created
  parent      ;-- owning nucleus
  parent-who  ;-- owning nucleus id
  local-lipid ;-- the lipid that the membrane notch is associated with
  protected
]
;;=====================================================================


;;=====================================================================
;; anti-CD19-diffusing notch

breed [anti-CD19-cleaved-notch-breed  anti-CD19-cleaved-notch]

anti-CD19-cleaved-notch-breed-own [
  birth       ;-- the tick that the original notch was created
  parent      ;-- owning nucleus
  parent-who  ;-- owning nucleus id
  time-cleaved;-- time the protein was cleaved and sent to nucleus
  indCleavedDiffTime
]
;;=====================================================================

;;=====================================================================
;; cleaved anti-CD19-notch that has reached nucleus and modulating transcription

breed [anti-CD19-notch-nuc-breed  anti-CD19-nucleus-notch]

anti-CD19-notch-nuc-breed-own [
  birth       ;-- the tick that the original notch was created
  parent      ;-- owning nucleus
  parent-who  ;-- owning nucleus id
  time-cleaved;-- time the protein was cleaved and sent to nucleus
  indCleavedDiffTime
  time-nuc    ;-- time the protein was cleaved and sent to nucleus
]
;;=====================================================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;; setup proceedure   ;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;; executed initially ;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to setup

  ;;--------------------------------------------------
  ;; initialize the space as empty
  clear-all
  ;;--------------------------------------------------

  ;;--------------------------------------------------
  ;; establish the random seed
  set current-seed new-seed
  random-seed current-seed
  ;;--------------------------------------------------

  ;;--------------------------------------------------
  ;; initialize all globals
  set radius          10
  set radiusFraction  0.0550
  set diameter        (radius * 2)
  set lipid-density    12

  set cell-row-cnt      7
  set cell-col-cnt     11
  set centersomeSize   10
  set deltaAge        400
  set notchAge        400


  set notch-cleaved-diffusion-time-signal (notch-cleaved-diffusion-time / 4.0)

  set lipid-distance     (radius / lipid-density)

  ;; specifies the granularity of the physical space and influences
  ;; distance components move.
  set unitMove (radius * radiusFraction)

  ;;--------------------------------------------------
  ;; initialize transcription to base rate
  set GFP-delta-transcription-rate GFP-delta-initial-rate
  set anti-GFP-notch-transcription-rate anti-GFP-initial-rate
  set anti-CD19-notch-transcription-rate anti-CD19-initial-rate
  ;;--------------------------------------------------

  ;;--------------------------------------------------
  ;; create the nucleus-breed
  layout-nucleus-breed-sheet
  ;;--------------------------------------------------

  ;;--------------------------------------------------
  ;; ask all nucleus to create a roset neighbor list

  ask sender-nucleus-breed [
    set roset-neighbors (turtle-set sender-nucleus-breed with [(self != myself) and (distance myself) < (diameter + 1)] receiver-nucleus-breed with [(self != myself) and (distance myself) < (diameter + 1)])
  ]

  ask receiver-nucleus-breed [
    set roset-neighbors (turtle-set sender-nucleus-breed with [(self != myself) and (distance myself) < (diameter + 1)] receiver-nucleus-breed with [(self != myself) and (distance myself) < (diameter + 1)])
  ]
  ;;--------------------------------------------------

  ;;--------------------------------------------------
  ;; create the cell lipids
  layout-lipids
  ;;--------------------------------------------------
  make-sender

  set Ecadherin-interactions 0
  set acceptions 0
  set rejections 0

  set all-cells (turtle-set sender-nucleus-breed receiver-nucleus-breed)
  reset-ticks

  vid:start-recorder
  vid:record-view ;; show the initial state
  repeat 1000
  [ go
    vid:record-view ]
  vid:save-recording "out.mp4"
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;; go proceedure      ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;; run with each tick ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to go-1

  go-x 1

end

to go-1000

  go-x 1000

end

to go-x [interations]

  print (word " ticks " ticks "   :  " date-and-time )

  repeat interations [go]

end


to go

  age-out-proteins    ;; remove proteins that have hit the maximum age

  transcribe-proteins ;; transcribe any new proteins

  diffuse-proteins    ;; diffuse all diffusable components

  transform-proteins  ;; perform all interprotein manipulations

  ;count-binds         ;; evaluate number of Ecadherin interactions after tranformation

  plot-current-data

  move-cells          ;; consider a switching of position between two cells and evaluate probability

  tick                ;; clock tick
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;; eliminate old proteins ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; ageout mechanism for the model
to age-out-proteins

  ask BFP-delta-breed            with [ticks > ( birth + deltaAge )] [ die ]
  ask BFP-delta-mem-breed        with [ticks > ( birth + deltaAge )] [ die ]
  ask GFP-delta-breed            with [ticks > ( birth + deltaAge )] [ die ]
  ask GFP-delta-mem-breed        with [ticks > ( birth + deltaAge )] [ die ]
  ask GFP-delta-mem-prime-breed  with [ticks > ( birth + deltaAge )] [ die ]

  ask Ecadherin-delta-breed            with [ticks > ( birth + deltaAge )] [ die ]
  ask Ecadherin-delta-mem-breed        with [ticks > ( birth + deltaAge )] [ die ]

  ask anti-CD19-notch-breed            with [ticks > ( birth + notchAge )] [ die ]
  ask anti-CD19-notch-mem-breed        with [ticks > ( birth + notchAge )] [ die ]

  ask anti-GFP-notch-breed            with [ticks > ( birth + notchAge )] [ die ]
  ask anti-GFP-notch-mem-breed        with [ticks > ( birth + notchAge )] [ die ]

  ; cleaved notch also provides protein tracking information
  ask anti-CD19-cleaved-notch-breed    with [ticks > ( birth + notchAge )] [ die ]
  ask anti-GFP-cleaved-notch-breed    with [ticks > ( birth + notchAge )] [ die ]

  ; protein production signal value is reduced as nuclear notch is
  ; removed

  ask anti-CD19-notch-nuc-breed        with [ticks > ( birth + notchAge )] [

    ask parent [
      set cleaved-nuc-anti-CD19-notch-count-value ( cleaved-nuc-anti-CD19-notch-count-value - 1 )
    ]

    die
  ]
  ask anti-GFP-notch-nuc-breed        with [ticks > ( birth + notchAge )] [

    ask parent [
      set cleaved-nuc-anti-GFP-notch-count-value ( cleaved-nuc-anti-GFP-notch-count-value - 1 )
    ]

    die
  ]

end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;; transcribe proteins ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to transcribe-proteins

  ask sender-nucleus-breed [

    set Ecadherin-transcription-rate (Ecadherin-transcription-initial-rate)

    ;; transcribe delta proteins
    if Ecadherin-transcription-rate >= random 100 [
      hatch-Ecadherin-delta-breed 1 [
        set birth      ticks
        set heading    (random 360)
        set color      white
        set shape      "diffuser1"
        set parent     myself
        set parent-who [who] of myself
      ]
    ]
  ]
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;; move proteins around cellspace ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to diffuse-proteins

  ;;--------------------------------------------------
  ;; diffuse non-lipid bound components
  diffuse-cytosol-proteins
  ;;--------------------------------------------------

  ;;--------------------------------------------------
  ;; diffuse proteins on lipid surface
  diffuse-lipid-proteins
  ;;--------------------------------------------------

end


;; proteins diffuse in cytosol by moving is specfic directions
;; or randomly moving.  The lipids help keep proteins from wandering
;; beyond the cell edge.
to diffuse-cytosol-proteins

  ;; diffuse transcribed delta-breed
  ask GFP-delta-breed [
    forward unitMove * 0.5
  ]
  ask CD19-delta-breed [
    forward unitMove * 0.5
  ]
  ask BFP-delta-breed [
    forward unitMove * 0.5
  ]

  ask Ecadherin-delta-breed [
    forward unitMove * 0.5
  ]

  ;; diffuse transcribed notches
  ask anti-GFP-notch-breed [
    forward unitMove * 0.5
  ]
  ask anti-CD19-notch-breed [
    forward unitMove * 0.5
  ]

end


;; proteins diffuse on the membranes by initially aligning with a
;; given lipid and then moving the the lipid on left or right
to diffuse-lipid-proteins

  let result 0

  ;; Ask lipid diffusers to move along the lipid
  ;; with equal probability of going left, right, or
  ;; remaining in the same location.

  ask lipid-breed [
    set curr-proteins nobody
  ]

  ask Ecadherin-delta-mem-breed [

    set result (random 3)

    if result = 0 [

      set local-lipid    [left-mem]  of local-lipid
      set xcor           [xcor]      of local-lipid
      set ycor           [ycor]      of local-lipid
      set heading        [heading]   of local-lipid
    ]

    if result = 1 [

      set local-lipid    [right-mem] of local-lipid
      set xcor           [xcor]      of local-lipid
      set ycor           [ycor]      of local-lipid
      set heading        [heading]   of local-lipid
    ]
    ask local-lipid [
      set curr-proteins (turtle-set curr-proteins myself)
    ]
  ]

   ask anti-GFP-notch-mem-breed [

    set result (random 3)

    if result = 0 [

      set local-lipid    [left-mem]  of local-lipid
      set xcor           [xcor]      of local-lipid
      set ycor           [ycor]      of local-lipid
      set heading        [heading]   of local-lipid
    ]

    if result = 1 [

      set local-lipid    [right-mem] of local-lipid
      set xcor           [xcor]      of local-lipid
      set ycor           [ycor]      of local-lipid
      set heading        [heading]   of local-lipid
    ]
    ask local-lipid [
      set curr-proteins (turtle-set curr-proteins myself)
    ]
  ]

  ask anti-CD19-notch-mem-breed [

    set result (random 3)

    if result = 0 [

      set local-lipid    [left-mem]  of local-lipid
      set xcor           [xcor]      of local-lipid
      set ycor           [ycor]      of local-lipid
      set heading        [heading]   of local-lipid
    ]

    if result = 1 [

      set local-lipid    [right-mem] of local-lipid
      set xcor           [xcor]      of local-lipid
      set ycor           [ycor]      of local-lipid
      set heading        [heading]   of local-lipid
    ]
    ask local-lipid [
      set curr-proteins (turtle-set curr-proteins myself)
    ]
  ]

  ask GFP-delta-mem-breed [

    set result (random 3)

    if result = 0 [
      set local-lipid    [left-mem]  of local-lipid
      set xcor           [xcor]      of local-lipid
      set ycor           [ycor]      of local-lipid
      set heading        [heading]   of local-lipid
    ]

    if result = 1 [
      set local-lipid    [right-mem] of local-lipid
      set xcor           [xcor]      of local-lipid
      set ycor           [ycor]      of local-lipid
      set heading        [heading]   of local-lipid
    ]

    ask local-lipid [
      set curr-proteins (turtle-set curr-proteins myself)
    ]
  ]

  ask BFP-delta-mem-breed [

    set result (random 3)

    if result = 0 [
      set local-lipid    [left-mem]  of local-lipid
      set xcor           [xcor]      of local-lipid
      set ycor           [ycor]      of local-lipid
      set heading        [heading]   of local-lipid
    ]

    if result = 1 [
      set local-lipid    [right-mem] of local-lipid
      set xcor           [xcor]      of local-lipid
      set ycor           [ycor]      of local-lipid
      set heading        [heading]   of local-lipid
    ]

    ask local-lipid [
      set curr-proteins (turtle-set curr-proteins myself)
    ]
  ]

  ask CD19-delta-mem-breed [

    set result (random 3)

    if result = 0 [
      set local-lipid    [left-mem]  of local-lipid
      set xcor           [xcor]      of local-lipid
      set ycor           [ycor]      of local-lipid
      set heading        [heading]   of local-lipid
    ]

    if result = 1 [
      set local-lipid    [right-mem] of local-lipid
      set xcor           [xcor]      of local-lipid
      set ycor           [ycor]      of local-lipid
      set heading        [heading]   of local-lipid
    ]

    ask local-lipid [
      set curr-proteins (turtle-set curr-proteins myself)
    ]
  ]

  ask GFP-delta-mem-prime-breed [

    set result (random 3)

    if result = 0 [
      set local-lipid    [left-mem]  of local-lipid
      set xcor           [xcor]      of local-lipid
      set ycor           [ycor]      of local-lipid
      set heading        [heading]   of local-lipid
    ]

    if result = 1 [
      set local-lipid    [right-mem] of local-lipid
      set xcor           [xcor]      of local-lipid
      set ycor           [ycor]      of local-lipid
      set heading        [heading]   of local-lipid
    ]

    ask local-lipid [
      set curr-proteins (turtle-set curr-proteins myself)
    ]
  ]

  ask CD19-delta-mem-prime-breed [

    set result (random 3)

    if result = 0 [
      set local-lipid    [left-mem]  of local-lipid
      set xcor           [xcor]      of local-lipid
      set ycor           [ycor]      of local-lipid
      set heading        [heading]   of local-lipid
    ]

    if result = 1 [
      set local-lipid    [right-mem] of local-lipid
      set xcor           [xcor]      of local-lipid
      set ycor           [ycor]      of local-lipid
      set heading        [heading]   of local-lipid
    ]

    ask local-lipid [
      set curr-proteins (turtle-set curr-proteins myself)
    ]
  ]
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; additional protein manipulations ;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; these are the trickiest but critical to the proper functioning
;; of the system.
to transform-proteins

  ;;-----------------------------------------------------------------
  ;;-----------------------------------------------------------------
  ;; ask lipids to pull diffusers on to the surface
  ask lipid-breed [

    ask Ecadherin-delta-breed in-radius (lipid-distance / 1) [

      set breed          Ecadherin-delta-mem-breed
      set xcor           [xcor]    of myself
      set ycor           [ycor]    of myself
      set heading        [heading] of myself
      set shape          "diffuser2"
      set mem-time       ticks

      set local-lipid myself
      ask local-lipid [
        set curr-proteins (turtle-set curr-proteins myself)
      ]
    ]

    ask GFP-delta-breed in-radius (lipid-distance / 1) [

      set breed          GFP-delta-mem-breed
      set xcor           [xcor]    of myself
      set ycor           [ycor]    of myself
      set heading        [heading] of myself
      set shape          "diffuser2"
      set mem-time       ticks

      set local-lipid myself
      ask local-lipid [
        set curr-proteins (turtle-set curr-proteins myself)
      ]
    ]

    ask CD19-delta-breed in-radius (lipid-distance / 1) [

      set breed          CD19-delta-mem-breed
      set xcor           [xcor]    of myself
      set ycor           [ycor]    of myself
      set heading        [heading] of myself
      set shape          "diffuser2"
      set mem-time       ticks

      set local-lipid myself
      ask local-lipid [
        set curr-proteins (turtle-set curr-proteins myself)
      ]
    ]

    ask BFP-delta-breed in-radius (lipid-distance / 1) [

      set breed          BFP-delta-mem-breed
      set xcor           [xcor]    of myself
      set ycor           [ycor]    of myself
      set heading        [heading] of myself
      set shape          "diffuser2"
      set mem-time       ticks

      set local-lipid myself
      ask local-lipid [
        set curr-proteins (turtle-set curr-proteins myself)
      ]
    ]

    ;;-- process transcribed notches --------------------------
    ask anti-GFP-notch-breed in-radius (lipid-distance / 1) [

      set breed          anti-GFP-notch-mem-breed
      set xcor           [xcor] of myself
      set ycor           [ycor] of myself
      set heading        [heading] of myself
      set shape          "diffuser2"
      ;set color          blue
      set local-lipid myself
      ask local-lipid [
        set curr-proteins (turtle-set curr-proteins myself)
      ]
    ]
    ask anti-CD19-notch-breed in-radius (lipid-distance / 1) [

      set breed          anti-CD19-notch-mem-breed
      set xcor           [xcor] of myself
      set ycor           [ycor] of myself
      set heading        [heading] of myself
      set shape          "diffuser2"
      ;set color          blue
      set local-lipid myself
      ask local-lipid [
        set curr-proteins (turtle-set curr-proteins myself)
      ]
    ]
  ]

  ;;-----------------------------------------------------------------
  ;;-----------------------------------------------------------------
  ;; Transform membrane delta to delta prime after a specific period,
  ;; if period is zero, do it autmatically.
  ifelse delta-transform-time = 0 [

    ask GFP-delta-mem-breed [
      set breed GFP-delta-mem-prime-breed
      set color green
    ]

  ][

    let transform-tick (ticks - delta-transform-time)
    ask GFP-delta-mem-breed [
      if mem-time < transform-tick [
        set breed GFP-delta-mem-prime-breed
        set color green
      ]
    ]
  ]

  ifelse delta-transform-time = 0 [

    ask CD19-delta-mem-breed [
      set breed CD19-delta-mem-prime-breed
      set color red
    ]

  ][

    let transform-tick (ticks - delta-transform-time)
    ask CD19-delta-mem-breed [
      if mem-time < transform-tick [
        set breed CD19-delta-mem-prime-breed
        set color red
      ]
    ]
  ]

  ;;-----------------------------------------------------------------
  ;;-----------------------------------------------------------------
  ;; ask all cleaved-notch agents to diffuse a certain amount
  ask anti-GFP-cleaved-notch-breed with [time-cleaved + indCleavedDiffTime < ticks] [

    set heading towards parent

    forward (distance parent) - (unitMove * centersomeSize) + 3

    set breed          anti-GFP-notch-nuc-breed

    ask parent [
      set cleaved-nuc-anti-GFP-notch-count-value ( cleaved-nuc-anti-GFP-notch-count-value + 1 )
    ]

    set time-nuc       ticks
  ]

  ask anti-CD19-cleaved-notch-breed with [time-cleaved + indCleavedDiffTime < ticks] [

    set heading towards parent

    forward (distance parent) - (unitMove * centersomeSize) + 3

    set breed          anti-CD19-notch-nuc-breed

    ask parent [
      set cleaved-nuc-anti-CD19-notch-count-value ( cleaved-nuc-anti-CD19-notch-count-value + 1 )
    ]

    set time-nuc       ticks
  ]

  ;;-----------------------------------------------------------------
  ;;-----------------------------------------------------------------
  ;; ask delta-mem-breed to laterally protect notches
  ask anti-CD19-notch-mem-breed [ set protected false ]
  ask anti-GFP-notch-mem-breed [ set protected false ]

  let protection nobody
  let ind-to-protect nobody

  ask CD19-delta-mem-prime-breed [

    ask local-lipid [

      set protection (turtle-set curr-proteins [curr-proteins] of left-mem [curr-proteins] of right-mem)

         set ind-to-protect (protection with [breed = anti-CD19-notch-mem-breed and protected = false])

         if ind-to-protect != nobody [

             ask ind-to-protect [set protected true]
           ]
         ]
       ]

 ask CD19-delta-mem-breed [

    ask local-lipid [

         set protection (turtle-set curr-proteins [curr-proteins] of left-mem [curr-proteins] of right-mem)

         set ind-to-protect (protection with [breed = anti-CD19-notch-mem-breed and protected = false])

         if ind-to-protect != nobody [

             ask ind-to-protect [set protected true]
           ]
         ]
      ]

  let p nobody

  ;;-----------------------------------------------------------------
  ;;-----------------------------------------------------------------
  ;; ask delta-mem-prime-breed to horizontally cleave notches
  let cntr 0
  let region-set nobody
  let ind-to-cleave nobody

  ask GFP-delta-mem-prime-breed [

    set cntr 0

    set region-set nobody

    ask local-lipid [

      if border-region != 0 [

         ask border-region [
           set region-set (turtle-set region-set curr-proteins)
         ]

         set ind-to-cleave one-of region-set with [breed = anti-GFP-notch-mem-breed and protected = false]

         if ind-to-cleave != nobody [

           set cntr (cntr + 1)

           ask ind-to-cleave [
             set breed           anti-GFP-cleaved-notch-breed
             set shape           "square"
             set color           red
             set heading towards parent

             set time-cleaved    ticks
             forward unitMove * 3

             ;; establish the time to destination for the current cleaved agent
             set indCleavedDiffTime (random-normal notch-cleaved-diffusion-time notch-cleaved-diffusion-time-signal)
           ]
         ]
      ]
    ]

    if cntr > 1 [
      print (word "number of cleaved anti-GFP-notch is " cntr)
    ]
  ]

  let cntr2 0
  let region-set2 nobody
  let ind-to-cleave2 nobody

  ask CD19-delta-mem-prime-breed [

    set cntr2 0

    set region-set2 nobody

    ask local-lipid [

      if border-region != 0 [

         ask border-region [
           set region-set2 (turtle-set region-set curr-proteins)
         ]

         set ind-to-cleave2 one-of region-set2 with [breed = anti-CD19-notch-mem-breed and protected = false]

         if ind-to-cleave2 != nobody [

           set cntr2 (cntr2 + 1)

           ask ind-to-cleave2 [
             set breed           anti-CD19-cleaved-notch-breed
             set shape           "square"
             set color           blue
             set heading towards parent

             set time-cleaved    ticks
             forward unitMove * 3

             ;; establish the time to destination for the current cleaved agent
             set indCleavedDiffTime (random-normal notch-cleaved-diffusion-time notch-cleaved-diffusion-time-signal)
           ]
         ]
      ]
    ]

    if cntr2 > 1 [
      print (word "number of cleaved anti-CD19-notch is " cntr2)
    ]
  ]

end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; proceedures for generating topology ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to layout-nucleus-breed-sheet

  let total-rows cell-row-cnt
  let total-cols cell-col-cnt
  let border-size 1
  let xborder border-size
  let yborder border-size + radius

  let row-pos 0
  let col-pos 0
  let row-cnt 0
  let col-cnt 0

  while [col-pos < total-cols] [

    ifelse col-pos = 0 [
      ;; create nucleus-breed for first column
      create-receiver-nucleus-breed total-rows [

        set   color gray
        set   shape "nucleus-breed"
        set   placed false

        ;; make room for a half row at the top
        setxy (radius + xborder) ( max-pycor - (radius + yborder))

      ]
    ][
      set row-cnt total-rows

      ;; create nucleus-breed for first column
      create-receiver-nucleus-breed row-cnt [

        set color    gray
        set shape   "nucleus-breed"
        set placed   false

        ;; make room for a half row at the top

        set col-cnt  0
        setxy (radius + xborder) ( max-pycor - (radius + yborder))

        while [col-cnt < col-pos] [

          ifelse (col-cnt mod 2) = 0 [
            set heading  60
          ][
            set heading 120
          ]

          forward diameter
          set col-cnt col-cnt + 1
        ]
      ]
    ]

    set row-pos 0

    foreach sort-by [ [?1 ?2] -> [who] of ?1 < [who] of ?2 ] (receiver-nucleus-breed with [placed = false])
    [ ?1 -> ask ?1 [

      ;; move starting column nucleus to start position
      set heading 180
      forward (row-pos * diameter)
      set row-pos row-pos + 1
      set placed true

    ] ]

    set col-pos col-pos + 1
  ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; misc. proceedures  ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;------------------------------------------------------
;--- generate the lipids ---------------------------
to layout-lipids

  ask receiver-nucleus-breed [

    ;--- build lipid set
    hatch-lipid-breed (lipid-density * 6) [
      set color yellow
      set shape "lipid"
      set parent myself
      set parent-who [who] of myself
    ]

    ;--- collect lipid proteins in agentset
    set lipid-set lipid-breed-here

    ;--- collect lipid proteins in ordered list
    let tempory-lipid-list sort lipid-set

    ;;;----------------------------------------------------------
    ;;;--- relate lipids to neighbors START-PROCESSING
    ; configure first lipid --------------------------------
    ask first tempory-lipid-list [
      set left-mem  (last   tempory-lipid-list)
      set right-mem (item 1 tempory-lipid-list)
    ]

    ; configure middle lipids --------------------------------
    let list-pos         1
    let middle-list-size (count lipid-set - 2)

    repeat middle-list-size [
      ask item list-pos tempory-lipid-list [
        set left-mem  item (list-pos - 1) tempory-lipid-list
        set right-mem item (list-pos + 1) tempory-lipid-list
      ]

      set list-pos (list-pos + 1)
    ]

    ; configure last lipid --------------------------------
    ask last tempory-lipid-list [
      set left-mem  (item  middle-list-size tempory-lipid-list)
      set right-mem (first                  tempory-lipid-list)
    ]
    ;;;--- relate lipids to neighbors   END-PROCESSING
    ;;;----------------------------------------------------------

    ;;;----------------------------------------------------------
    ;;;--- place lipid proteins       START-PROCESSING
    ; initialize nucleus-breed variables -----------------------------
    let lipid-cnt     0
    set lipid-start  -1

    ;--- initialize local variables ---------------------------
    let moveIncrement   (radius / lipid-density)
    let incrementSteps   0
    let hex-edge         0

    foreach tempory-lipid-list [ ?1 ->

      if (incrementSteps = lipid-density) [
        set hex-edge       (hex-edge + 1)
        set incrementSteps 0
      ]

      ask ?1 [

        ;;;--- define first and last lipid in nucleus
        if [lipid-start] of myself = -1 [
          ask myself [
            set lipid-start myself
          ]
        ]

        ask myself [
          set lipid-end myself
        ]

        ;;;--- move lipid to corner
        set heading (hex-edge * 60 + 30)
        forward radius

        ;;;--- move non-corner lipid along the edge
        if incrementSteps > 0 [
          set heading (heading + 120)
          forward (incrementSteps * moveIncrement)
          set heading (heading - 90)
        ]
      ]

      set incrementSteps (incrementSteps + 1)
    ]
    ;;;--- place lipid proteins        END-PROCESSING
    ;;;----------------------------------------------------------
  ]

  ;draw-centersome

  let region nobody
  ask lipid-breed [

    set region lipid-breed in-cone (lipid-distance * 4) 45

    if (count region) > 1 [

      set border-region region with [self != myself]

    ]
  ]

end

to draw-centersome

  let dia    (unitMove * centersomeSize * 2)
  let circum (pi * dia)
  ask receiver-nucleus-breed [
    hatch 1 [
      set color   gray
      set heading 0

      forward dia / 2
      rt 90
      pd

      forward (circum / 360)
      rt 1

      while [heading != 90] [
        forward (circum / 360)
        rt 1
      ]

      die

    ]
  ]

end

to make-sender
  ask n-of senders receiver-nucleus-breed [
    set breed       sender-nucleus-breed
    set shape "nucleus-breed-special"
    set color green
  ]
end

to count-binds
  let region-set nobody
  let ind-to-bind nobody
  let bind-count nobody
  ask Ecadherin-delta-mem-breed [

    set region-set nobody
    set ind-to-bind nobody

    ask local-lipid [

      if border-region != 0 [

         ask border-region [
           set region-set (turtle-set region-set curr-proteins)
         ]

         set ind-to-bind region-set with [breed = Ecadherin-delta-mem-breed]

         if ind-to-bind != nobody [

           ask ind-to-bind [
             set bind-count (turtle-set bind-count ind-to-bind)
           ]
         ]
      ]
    ]
  ]
  if bind-count != nobody [
  set Ecadherin-Interactions (count bind-count / 2)
  ]
end


to move-cells
  ;; ask all lipids to update their interaction regions
  let region nobody
  ask lipid-breed [

    set region lipid-breed in-cone (lipid-distance * 4) 45

    if (count region) > 1 [

      set border-region region with [self != myself]

    ]
  ]

  let region-set nobody
  let ind-to-bind nobody
  let bind-count nobody

  set bind-count 0
  ask Ecadherin-delta-mem-breed [

    set region-set nobody
    set ind-to-bind nobody

    ask local-lipid [

      if border-region != 0 [

        ask border-region [
          set region-set (turtle-set region-set curr-proteins)
        ]

        set ind-to-bind region-set with [breed = Ecadherin-delta-mem-breed]

        if ind-to-bind != nobody [
          set bind-count curr-proteins
          ask ind-to-bind [
            create-links-with bind-count with [breed = Ecadherin-delta-mem-breed]
          ]
        ]
      ]
    ]
  ]
  ask links [
    if link-length > lipid-distance * 4 [
      die
    ]
  ]
  set Ecadherin-Interactions count links

  let old-lipids 0
  let new-lipids 0
  let old-x 0
  let old-y 0
  let new-x 0
  let new-y 0
  let mover nobody
  let old-nuc-x 0
  let old-nuc-y 0
  let new-nuc-x 0
  let new-nuc-y 0
  let new-distance 0
  let mover-cytosol-set nobody
  let target-cytosol-set nobody
  let target 0

  set old-lipids 0
  set new-lipids 0
  set old-x 0
  set old-y 0
  set new-x 0
  set new-y 0
  set mover nobody
  set old-nuc-x 0
  set old-nuc-y 0
  set new-nuc-x 0
  set new-nuc-y 0
  set new-distance 0
  set mover-cytosol-set nobody
  set target-cytosol-set nobody
  set target 0

  set mover one-of sender-nucleus-breed ;all-cells
  ask mover [
    set old-lipids sort lipid-set
    set target one-of roset-neighbors
    set old-nuc-x [xcor] of self
    set old-nuc-y [ycor] of self
    set mover-cytosol-set (turtle-set Ecadherin-delta-breed with [distance myself < radius + 1])
  ]

  ask target [
    set new-lipids sort lipid-set
    set new-nuc-x [xcor] of self
    set new-nuc-y [ycor] of self
    set target-cytosol-set (turtle-set Ecadherin-delta-breed with [distance myself < radius + 1])
  ]

  let list-pos 0
  let list-pos2 0

  set list-pos 0
  repeat 72 [
    set old-x [xcor] of item (list-pos) old-lipids
    set old-y [ycor] of item (list-pos) old-lipids
    set new-x [xcor] of item (list-pos) new-lipids
    set new-y [ycor] of item (list-pos) new-lipids

    ask item list-pos old-lipids [
      setxy  new-x new-y
    ]
    ask item list-pos new-lipids [
      setxy old-x old-y
    ]
      set list-pos (list-pos + 1)
    ]

  ask Ecadherin-delta-mem-breed [

      set xcor           [xcor]      of local-lipid
      set ycor           [ycor]      of local-lipid
      set heading        [heading]   of local-lipid

  ]
  ;; ask all lipids to update their interaction regions
  set region nobody
  ask lipid-breed [

    set region lipid-breed in-cone (lipid-distance * 4) 45

    if (count region) > 1 [

      set border-region region with [self != myself]

    ]
  ]

  set region-set nobody
  set ind-to-bind nobody

  set bind-count 0

  ask Ecadherin-delta-mem-breed [

    set region-set nobody
    set ind-to-bind nobody

    ask local-lipid [

      if border-region != 0 [

         ask border-region [
           set region-set (turtle-set region-set curr-proteins)
         ]

         set ind-to-bind region-set with [breed = Ecadherin-delta-mem-breed ]

        if ind-to-bind != nobody [
         set bind-count curr-proteins
          ask ind-to-bind [
          create-links-with bind-count with [breed = Ecadherin-delta-mem-breed]
        ]
      ]
    ]
  ]
  ]
ask links [
    if link-length > lipid-distance * 4 [
      die
    ]
  ]
  set temp-count (count links)


  ifelse (temp-count) >= Ecadherin-Interactions or (exp ((temp-count - Ecadherin-Interactions) * Cadherin-Energy)) * 100 >= random 99 + 1 [
    ask mover [
      setxy new-nuc-x new-nuc-y
    ]

    ask target [
      setxy old-nuc-x old-nuc-y
    ]

    ask mover-cytosol-set[
      set new-distance distance target
      move-to mover
      fd new-distance
    ]

    ask target-cytosol-set[
      set new-distance distance mover
      move-to target
      fd new-distance
    ]

    ask sender-nucleus-breed [
      set roset-neighbors (turtle-set sender-nucleus-breed with [(self != myself) and (distance myself) < (diameter + 1)] receiver-nucleus-breed with [(self != myself) and (distance myself) < (diameter + 1)])
    ]

    ask receiver-nucleus-breed [
      set roset-neighbors (turtle-set sender-nucleus-breed with [(self != myself) and (distance myself) < (diameter + 1)] receiver-nucleus-breed with [(self != myself) and (distance myself) < (diameter + 1)])
    ]
    set acceptions (acceptions + 1)
  ][
    set list-pos2 0
    set old-x 0
    set old-y 0
    set new-x 0
    set new-y 0

    repeat 72 [
      set old-x [xcor] of item (list-pos2) old-lipids
      set old-y [ycor] of item (list-pos2) old-lipids
      set new-x [xcor] of item (list-pos2) new-lipids
      set new-y [ycor] of item (list-pos2) new-lipids

      ask item list-pos2 old-lipids [
        setxy  new-x new-y
      ]
      ask item list-pos2 new-lipids [
        setxy old-x old-y
      ]
      set list-pos2 (list-pos2 + 1)
    ]

    ask Ecadherin-delta-mem-breed [

      set xcor           [xcor]      of local-lipid
      set ycor           [ycor]      of local-lipid
      set heading        [heading]   of local-lipid
    ]

    set region nobody
    ask lipid-breed [

      set region lipid-breed in-cone (lipid-distance * 4) 45
      if (count region) > 1 [
        set border-region region with [self != myself]
      ]
    ]
  ]
  set rejections (rejections + 1)
end

to plot-current-data

  set-current-plot "Cadherin Interactions"
  plot Ecadherin-Interactions

end
@#$#@#$#@
GRAPHICS-WINDOW
231
11
1244
825
-1
-1
5.0
1
10
1
1
1
0
0
0
1
0
200
-60
100
0
0
1
ticks
30.0

INPUTBOX
7
733
162
793
current-seed
1.167494809E9
1
0
Number

BUTTON
23
96
87
129
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
99
96
162
129
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
23
139
86
172
NIL
go-1
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
9
366
183
399
delta-transform-time
delta-transform-time
0
150
0.0
50
1
NIL
HORIZONTAL

SLIDER
9
408
217
441
notch-cleaved-diffusion-time
notch-cleaved-diffusion-time
75
225
0.0
50
1
NIL
HORIZONTAL

BUTTON
99
140
177
173
NIL
go-1000
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
9
301
215
334
anti-CD19-initial-rate
anti-CD19-initial-rate
8
24
8.0
2
1
NIL
HORIZONTAL

SLIDER
9
265
181
298
anti-GFP-initial-rate
anti-GFP-initial-rate
8
24
0.0
2
1
NIL
HORIZONTAL

SLIDER
9
203
181
236
GFP-delta-initial-rate
GFP-delta-initial-rate
8
24
0.0
2
1
NIL
HORIZONTAL

SLIDER
11
489
183
522
senders
senders
1
77
14.0
1
1
NIL
HORIZONTAL

SLIDER
16
616
188
649
Cadherin-Energy
Cadherin-Energy
0.01
0.1
0.01
0.01
1
NIL
HORIZONTAL

SLIDER
1342
197
1580
230
Ecadherin-transcription-initial-rate
Ecadherin-transcription-initial-rate
0
100
30.0
1
1
NIL
HORIZONTAL

PLOT
1264
290
1580
544
Cadherin Interactions
Ticks
Interactions
0.0
2500.0
0.0
500.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot Ecadherin-Interactions"

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
4
Circle -7500403 true false 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

diffuser1
true
10
Circle -13345367 true true 96 96 108

diffuser2
true
1
Rectangle -2674135 true true 121 46 181 256

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

lipid
true
4
Rectangle -1184463 true true 120 45 180 255

nucleus-breed
true
15
Circle -1 true true 45 45 210

nucleus-breed-special
true
0
Circle -7500403 true true 0 0 300

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.0.4
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
