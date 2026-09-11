# testdsxc1 — PRD

## Problem Statement

The organization staffs customer engagements by allocating team members to them, but today that allocation is tracked informally (spreadsheets, chat threads, memory). Engagement Managers cannot see who is available, Resource Managers cannot see who is over-committed until it is too late, and Team Members often learn what they are staffed on secondhand. The result is over-allocated people, under-staffed engagements, and no single place to see who is working on what.

## Solution

A web application that centralizes team member allocation to customer engagements. Engagement Managers request team members for their engagements; Resource Managers review those requests against everyone's current and upcoming capacity and approve or reject them; approved requests become confirmed allocations that both the Team Member and the Engagement Manager can see. The system tracks allocation as a percentage of a team member's time over a date range, so utilization and over-allocation are visible before they become a problem.

## Actors

- **Resource Manager**: owns the team member roster and the allocation pool; reviews, approves, or rejects allocation requests; sees each team member's current and upcoming utilization; creates, edits, and cancels allocations.
- **Engagement Manager**: owns customer engagements; requests team members against an engagement; tracks the status of their own requests; sees who is currently allocated to their engagements.
- **Team Member**: sees their own current and upcoming allocations, and their own overall utilization.

## User Stories

1. As an Engagement Manager, I want to create and manage a customer engagement (name, customer, start/end dates), so that I have something to staff.
2. As an Engagement Manager, I want to close/end a customer engagement, so that its allocations end and the team members on it free up capacity.
3. As an Engagement Manager, I want to submit a request for a team member on one of my engagements, specifying the role/skill needed, the percentage of time, and a date range, so that the Resource Manager knows what to staff. *assumed*
4. As an Engagement Manager, I want to see the status of every request I've submitted (pending, approved, rejected), so that I know whether my engagement is staffed.
5. As an Engagement Manager, I want to see who is currently allocated to my engagements and at what percentage, so that I have visibility into my own staffing.
6. As a Resource Manager, I want to see a queue of pending allocation requests, so that I can work through them.
7. As a Resource Manager, I want to see a team member's current and upcoming allocations and total utilization percentage before approving a new request for them, so that I can make an informed decision.
8. As a Resource Manager, I want to be warned when approving a request would push a team member over 100% allocated, so that I don't overcommit someone, while still being able to override the warning when the business needs it. *assumed*
9. As a Resource Manager, I want to approve a pending request and assign a specific team member to it, so that it becomes a confirmed allocation.
10. As a Resource Manager, I want to reject a pending request with a reason, so that the Engagement Manager understands why and can adjust.
11. As a Resource Manager, I want to edit or cancel an existing allocation (percentage, dates, or removal), so that I can adjust staffing as engagements change after approval.
12. As a Resource Manager, I want to manage the roster of team members (add, edit, deactivate; name, role/title, skills), so that the allocation pool reflects who is actually available to staff. *assumed*
13. As a Team Member, I want to view my own current and upcoming allocations across engagements and my overall utilization percentage, so that I know what I'm staffed on.
14. As an Engagement Manager or Resource Manager, I want to receive an email when a request is submitted or decided, so that I don't have to keep checking the app for updates.

## Product Decisions

- **Sign-in**: all actors sign in via SSO through Thunder, the platform identity provider.
- **Allocation workflow**: request → approval → assignment. Engagement Managers submit requests; Resource Managers approve or reject them; only an approved request becomes a confirmed allocation.
- **Allocation unit**: a percentage of a team member's time over a start/end date range (not hours, not full-time-only).
- **Notifications**: transactional email — SendGrid, an existing organizational resource already provisioned for allocation-request and allocation-decision events.
- **Over-allocation handling**: the system warns the Resource Manager rather than hard-blocking the approval, so an exception can still be made. *assumed*
- **Team member roster**: managed inside this application by the Resource Manager, not imported from an external HR system. *assumed*

## Out of Scope

- Skills-based matching or automatic recommendation of who to allocate.
- Timesheets, time tracking, or actual-hours reporting.
- Billing, invoicing, or margin/cost reporting on engagements.
- Integration with external HR or ERP systems for the team member roster.
- Native mobile application.

## Open Questions

None at this time.