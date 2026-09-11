# Allocation Request &amp; Approval

An Engagement Manager requests a team member for an engagement; a Resource Manager reviews capacity, approves and assigns a team member (or rejects), both sides get notified by email, and the Team Member sees the resulting allocation.

```mermaid
sequenceDiagram
    actor EngMgr as Engagement Manager
    actor ResMgr as Resource Manager
    actor TeamMember as Team Member
    participant allocation-webapp
    participant allocation-api
    participant sendgrid

    EngMgr->>allocation-webapp: submit request (role, %, dates)
    allocation-webapp->>allocation-api: create allocation request
    allocation-api-->>allocation-webapp: request pending

    ResMgr->>allocation-webapp: open request queue
    allocation-webapp->>allocation-api: list pending requests
    allocation-api-->>allocation-webapp: requests + team member capacity

    ResMgr->>allocation-webapp: approve, assign team member
    allocation-webapp->>allocation-api: approve request (teamMemberId)
    alt would exceed 100% allocated
        allocation-api-->>allocation-webapp: over-allocation warning
        ResMgr->>allocation-webapp: confirm anyway
        allocation-webapp->>allocation-api: confirm approval
    end
    allocation-api->>sendgrid: send decision email
    allocation-api-->>allocation-webapp: allocation confirmed

    TeamMember->>allocation-webapp: view my allocations
    allocation-webapp->>allocation-api: get my allocations
    allocation-api-->>allocation-webapp: allocations + utilization
```

