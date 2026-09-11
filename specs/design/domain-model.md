# Domain Model

The allocation system tracks customer engagements, the team member roster, requests to staff an engagement, and the confirmed allocations those requests become.

```mermaid
erDiagram
    ENGAGEMENT ||--o{ ALLOCATION_REQUEST : "staffed via"
    ENGAGEMENT ||--o{ ALLOCATION : "staffed by"
    TEAM_MEMBER ||--o{ ALLOCATION : "assigned to"
    ALLOCATION_REQUEST ||--o| ALLOCATION : "becomes"

    ENGAGEMENT {
        string id
        string name
        string customerName
        date startDate
        date endDate
        string status
    }
    TEAM_MEMBER {
        string id
        string name
        string roleTitle
        string skills
        boolean active
    }
    ALLOCATION_REQUEST {
        string id
        string engagementId
        string roleNeeded
        int percentage
        date startDate
        date endDate
        string status
        string requestedBy
        string decisionReason
    }
    ALLOCATION {
        string id
        string requestId
        string engagementId
        string teamMemberId
        int percentage
        date startDate
        date endDate
        string status
    }
```

An `ENGAGEMENT` accumulates `ALLOCATION_REQUEST`s as an Engagement Manager asks for staff. A Resource Manager approves a request, naming a `TEAM_MEMBER`, and the request becomes an `ALLOCATION` — the confirmed record both the Team Member and the Engagement Manager see. Utilization for a team member is the sum of `percentage` across their active/upcoming `ALLOCATION`s.