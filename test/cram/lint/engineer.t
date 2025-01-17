Engineer reports
----------------

This is a valid one:

  $ okra lint --engineer << EOF
  > # Projects
  > 
  > - Project1 (KR1)
  > - Project2 (KR2)
  > - Project3 (#3)
  > 
  > This is not formatted.
  > 
  > # Last week
  > 
  > - This is a WI (#123)
  >   - @eng1 (1 day)
  >   - My work
  > 
  > - This is a KR (KR123)
  >   - @eng1 (1 day)
  >   - My work
  > 
  > - A KR yet to have an id (New KR)
  >   - @eng1 (1 day)
  >   - Some work
  > 
  > - A work without a KR (No KR)
  >   - @eng1 (1 day)
  >   - Some work
  > 
  > # Activity
  > 
  > More unformatted text.
  > EOF
  [OK]: <stdin>

Errors in include section are detected even if the rest is ignored.

  $ okra lint --engineer << EOF
  > # Projects
  > 
  > - Project1 (KR1)
  > - Project2 (KR2)
  > 
  > This is not formatted.
  > 
  > # Last week
  > 
  > - This is a KR (KRID)
  >   - (1 day)
  >   - My work
  > 
  > # Activity
  > 
  > More unformatted text.
  > EOF
  [ERROR(S)]: <stdin>
  
  In KR "This is a KR (KRID)":
    No time entry found. Each KR must be followed by '- @... (x days)'
  [1]

Only "No KR" and "New KR" are supported for KR's without identifiers

  $ okra lint --engineer << EOF
  > # Projects
  > 
  > - Project1 (KR1)
  > - Project2 (KR2)
  > 
  > This is not formatted.
  > 
  > # Last week
  > 
  > - This is a KR (Off KR)
  >   - @eng1 (1 day)
  >   - My work
  > 
  > # Activity
  > 
  > More unformatted text.
  > EOF
  [ERROR(S)]: <stdin>
  
  In KR "This is a KR (Off KR)":
    No KR ID found. WIs should be in the format "This is a WI (#123)", where 123 is the WI issue ID. Legacy KRs should be in the format "This is a KR (PLAT123)", where PLAT123 is the KR ID. For WIs that don't have an ID yet, use "New WI" and for work without a WI use "No WI".
  [1]
