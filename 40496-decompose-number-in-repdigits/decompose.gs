;{].`(;);puts~}:DEBUG;
{ .@.@={;;'OK.'}{'FAIL! ['\+'] does not equal ['+\']!'++}if puts}:assert_equals;

{
  .0>2*(.@*`.,\[0=]*''+~*


}:closest_rep;

; 24192 closest_rep  22222 assert_equals
;   113 closest_rep    111 assert_equals
;     7 closest_rep      7 assert_equals
;   -46 closest_rep    -44 assert_equals

{
  .closest_rep-
}:decompose_next

;  24192 decompose_next  1970  assert_equals
;    860 decompose_next   -28  assert_equals
;      7 decompose_next     0  assert_equals


{
  .`,:l;.
  [
    {
      .closest_rep.@\-.
    }do;
  ]
  -1%
  {
    [.0>' +'=\`n].1=,l\-' '*\+
  }%
  '='@n

}:full_program;

#;  24192 full_program 


{
# ~.`,:l;.[{..0>2*(.@*`.,\[0=]*''+~*.@\-.}do;]-1%{[.0>' +'=\`n].1=,l\-' '*\+}%'='@n

  # inlined variable `l`
# ~.[{..0>2*(.@*`.,\[0=]*''+~*.@\-.}do;]-1%{[.0>' +'=\`n].1=,2$`,\-' '*\+}%'='@n

  # no need for trailing `n`
  ~.[{..0>2*(.@*`.,\[0=]*''+~*.@\-.}do;]-1%{[.0>' +'=\`n].1=,2$`,\-' '*\+}%'='@

}:golfed;

;  '24192' golfed n n
;  '187863132' golfed n n
;  '-2' golfed n n


