screen EngagementsList "Engagement Manager's list of customer engagements"
  navbar "Allocation Manager"
  sidebar "Engagements -> EngagementsList | My Requests -> RequestsList"
  row
    heading "Engagements"
    right
    button "New Engagement" primary -> NewEngagement
  table "Name | Customer | Start | End | Status" -> EngagementDetail
    row "Acme Migration | Acme Corp | 2026-01-01 | 2026-06-30 | Active"
    row "Globex Rollout | Globex Inc | 2026-02-15 | 2026-09-01 | Active"

screen NewEngagement "Create a customer engagement"
  navbar "Allocation Manager"
  sidebar "Engagements -> EngagementsList | My Requests -> RequestsList"
  heading "New Engagement"
  input "Engagement name"
  input "Customer name"
  input "Start date"
  input "End date"
  row
    right
    button "Cancel" -> EngagementsList
    button "Create" primary -> EngagementsList

screen EngagementDetail "A single engagement's requests and current staffing"
  navbar "Allocation Manager"
  sidebar "Engagements -> EngagementsList | My Requests -> RequestsList"
  row
    heading "Acme Migration"
    right
    badge "Active" success
    button "Close Engagement" danger
  button "Request Team Member" primary -> NewRequest
  heading "Current Allocations"
  table "Team Member | Role | % | Start | End"
    row "Jane Doe | Senior Developer | 50% | 2026-01-01 | 2026-06-30"
  heading "Requests"
  table "Role | % | Status" -> RequestsList
    row "QA Engineer | 30% | Pending"

screen NewRequest "Submit a request for a team member on an engagement"
  navbar "Allocation Manager"
  sidebar "Engagements -> EngagementsList | My Requests -> RequestsList"
  heading "Request a Team Member"
  select "Engagement"
  input "Role / skill needed"
  input "Percentage of time"
  input "Start date"
  input "End date"
  row
    right
    button "Cancel" -> EngagementDetail
    button "Submit Request" primary -> RequestsList

screen RequestsList "Engagement Manager's own allocation requests and their status"
  navbar "Allocation Manager"
  sidebar "Engagements -> EngagementsList | My Requests -> RequestsList"
  heading "My Requests"
  table "Engagement | Role | % | Status"
    row "Acme Migration | QA Engineer | 30% | Pending"
    row "Globex Rollout | Senior Developer | 50% | Approved"

screen RequestQueue "Resource Manager's queue of pending allocation requests"
  navbar "Allocation Manager"
  sidebar "Request Queue -> RequestQueue | Team Roster -> TeamRoster | Allocations -> AllocationsList"
  heading "Pending Requests"
  table "Engagement | Role | % | Dates" -> RequestDetail
    row "Acme Migration | QA Engineer | 30% | 2026-03-01 to 2026-08-01"
    row "Globex Rollout | Senior Developer | 50% | 2026-02-15 to 2026-09-01"

screen RequestDetail "Review a pending request, check capacity, and decide"
  navbar "Allocation Manager"
  sidebar "Request Queue -> RequestQueue | Team Roster -> TeamRoster | Allocations -> AllocationsList"
  heading "QA Engineer — 30% — Acme Migration"
  text "Requested by: Alex Engagement Manager"
  select "Assign team member"
  card "Selected member utilization"
    progress "70%"
    badge "Would exceed 100%" warning
  row
    right
    button "Reject" danger -> RequestQueue
    button "Approve" primary -> RequestQueue

screen TeamRoster "Resource Manager's team member roster"
  navbar "Allocation Manager"
  sidebar "Request Queue -> RequestQueue | Team Roster -> TeamRoster | Allocations -> AllocationsList"
  row
    heading "Team Roster"
    right
    button "Add Team Member" primary -> NewTeamMember
  table "Name | Role/Title | Skills | Active" -> TeamMemberDetail
    row "Jane Doe | Senior Developer | Java, React | Yes"
    row "Sam Lee | QA Engineer | Selenium, API testing | Yes"

screen NewTeamMember "Add a team member to the roster"
  navbar "Allocation Manager"
  sidebar "Request Queue -> RequestQueue | Team Roster -> TeamRoster | Allocations -> AllocationsList"
  heading "Add Team Member"
  input "Name"
  input "Role / title"
  input "Skills"
  row
    right
    button "Cancel" -> TeamRoster
    button "Add" primary -> TeamRoster

screen TeamMemberDetail "A team member's current/upcoming allocations and utilization"
  navbar "Allocation Manager"
  sidebar "Request Queue -> RequestQueue | Team Roster -> TeamRoster | Allocations -> AllocationsList"
  heading "Jane Doe — Senior Developer"
  card "Total Utilization | 80% | across 2 engagements"
  table "Engagement | % | Start | End" -> AllocationsList
    row "Acme Migration | 50% | 2026-01-01 | 2026-06-30"
    row "Globex Rollout | 30% | 2026-02-15 | 2026-09-01"

screen AllocationsList "All confirmed allocations, editable by a Resource Manager"
  navbar "Allocation Manager"
  sidebar "Request Queue -> RequestQueue | Team Roster -> TeamRoster | Allocations -> AllocationsList"
  heading "Allocations"
  table "Team Member | Engagement | % | Start | End" -> TeamMemberDetail
    row "Jane Doe | Acme Migration | 50% | 2026-01-01 | 2026-06-30"
    row "Sam Lee | Acme Migration | 30% | 2026-03-01 | 2026-08-01"
  row
    right
    button "Edit" -> TeamMemberDetail
    button "Cancel Allocation" danger

screen MyAllocations "A Team Member's own current and upcoming allocations and utilization"
  navbar "Allocation Manager"
  sidebar "My Allocations -> MyAllocations"
  heading "My Allocations"
  card "Total Utilization | 80% | across 2 engagements"
  table "Engagement | % | Start | End"
    row "Acme Migration | 50% | 2026-01-01 | 2026-06-30"
    row "Globex Rollout | 30% | 2026-02-15 | 2026-09-01"

flow "Manage engagements & requests"
  role "Engagement Manager"
  description "An Engagement Manager staffs their engagements by submitting requests and tracking their outcome"
  EngagementsList
  NewEngagement
  EngagementDetail
  NewRequest
  RequestsList

flow "Review and approve allocations"
  role "Resource Manager"
  description "A Resource Manager works the request queue, checks capacity, decides, and manages the roster and allocations"
  RequestQueue
  RequestDetail
  TeamRoster
  NewTeamMember
  TeamMemberDetail
  AllocationsList

flow "View my allocations"
  role "Team Member"
  description "A Team Member checks what they are currently staffed on and their overall utilization"
  MyAllocations
