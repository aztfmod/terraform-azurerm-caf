---
name: User Story
about: Describe this issue template's purpose here.
title: "[enhancement]"
labels: enhancement
assignees: ''

---

## User stories

A user story is implemented as well as it is communicated.
If the context and the goals are made clear, it will be easier for everyone to implement it, test it, refer to it…

---

Quick links: [Summary](#summary) | [Description](#description) | [Template](#template) | [Example](#example) | [Resources](#resources)

---

### Summary

A user story should typically have a summary structured this way:

1. **As a** [user concerned by the story]
1. **I want** [goal of the story]
1. **so that** [reason for the story]

The “so that” part is optional if more details are provided in the description.

This can then become “As a user managing my properties, I want notifications when adding or removing images.”

You can read about some reasons for this structure in this [nicely put article][1].

### Description

We’re using the following template to create user stories. 

Since we have mentioned the type of user, the user story can refer to it with “I”.
This is useful for **consistency** and to **avoid repetition** in the Acceptance criteria.
It’s also good to practice a little **empathy**.

For example:

```markdown
1. I click on the “submit” button.
1. A modal window appears if I don’t have enough credits.
1. The modal window contains the following:
  1. […]
```

The template uses [markdown][2].
You should get familiar with it if you’re not already, **it’s awesome!**

### Template

```markdown
[
The user story should have a reason to exist: what do I need as the user described in the summary?
This part details any detail that could not be passed by the summary.
]


### Acceptance Criteria

1. [If I do A.]
1. [B should happen.]

[
Also, here are a few points that need to be addressed:

1. Constraint 1;
1. Constraint 2;
1. Constraint 3.
]


### Resources:

* Runbook: [Here goes a URL to Manual Steps];
* Testing URL: [Here goes a URL Manual testing report];



### Notes

[Some complementary notes if necessary:]

* > Here goes a quote from an email
* Here goes whatever useful information can exist…
```

# Sprint Ready Checklist 
1. - [ ] Acceptance criteria defined 
2. - [ ] Team understands acceptance criteria 
3. - [ ] Team has defined solution / steps to satisfy acceptance criteria 
4. - [ ] Acceptance criteria is verifiable / testable 
5. - [ ] External / 3rd Party dependencies identified
