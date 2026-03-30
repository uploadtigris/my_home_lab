# DevOps/SRE Learning Roadmap

A structured sequence for building proficiency in Python, Docker, Kubernetes, Terraform, and AWS — optimized for junior SRE/DevOps/Linux Systems Engineer roles.

---

## Two Categories of Skill

**Tool skills** — Docker, Kubernetes, Terraform, AWS. Learned by doing. The concepts are shallow enough that you don't need to master theory first; you need reps with real tasks. Courses work as guided scaffolding, but only if they force you to actually run things, not just watch.

**Language skills** — Python. You already have foundational Python. What you need isn't more syntax — it's fluency through building real things that feel like work you'd actually do on the job.

---

## Sequence

> Learn one thing at a time. Learning everything in parallel dilutes all of it.

### 1. Python *(Now + ongoing, 45–60 min/day)*

You don't need a course — you need reps. Write scripts that do real sysadmin work:

- Parse logs
- Hit APIs
- Check service health
- Wrap shell commands with `subprocess`

**Approach:** Build Your Own X style. Not tutorials. Real scripts that do real things.

**Key stdlib to focus on:** `argparse`, `subprocess`, `requests`, `json`, `os`, `pathlib`

---

### 2. AWS Solutions Architect Associate *(Now, parallel with Python — 8–10 weeks)*

Highest ROI credential given Amazon employment (discount + internal visibility). Do this alongside Python, not instead of it.

**Resource:** [Adrian Cantrill's SAA course](https://cantrill.io) — gold standard. Project-heavy, builds genuine understanding rather than just exam prep.

**Supplement:** Tutorials Dojo practice exams for the final 2–3 weeks.

---

### 3. Docker *(Baked into Python projects — already in progress)*

Don't take a separate Docker course. Deepen it by containerizing everything you build. Real Docker knowledge comes from friction with real projects.

**Current focus:** Multi-stage builds, bind mounts vs volumes, environment variable handling, `docker compose` for multi-container projects.

---

### 4. Terraform *(After AWS SAA)*

Terraform makes much more sense once you understand what AWS resources *are*. Terraforming things you don't understand is a fast way to spin your wheels.

**Resource:** [HashiCorp Developer Learn platform](https://developer.hashicorp.com/terraform/tutorials) + `#90DaysOfDevOps` Terraform sections.

**Starting projects:**
- Provision a VPC and EC2 instance
- Add an S3 bucket with lifecycle rules
- Modularize and reuse configs

---

### 5. Kubernetes *(After Docker is solid)*

Kubernetes is Docker with significantly more operational surface area. Don't rush here before containers feel natural.

**Resource:** [TechWorld with Nana — Kubernetes full course (YouTube, free)](https://www.youtube.com/c/TechWorldwithNana)

**Path:** Local cluster with `kind` or `minikube` → deploy containerized Python apps → add Services, ConfigMaps, and health probes → explore Helm basics.

---

## Summary Table

| Priority | Skill | Approach | Timing |
|---|---|---|---|
| 1 | Python | Build real scripts, not tutorials | Now + ongoing |
| 2 | AWS SAA | Cantrill course + practice exams | Now, 8–10 weeks |
| 3 | Docker | Embedded in Python projects | Already in progress |
| 4 | Terraform | HashiCorp Learn + small infra projects | After SAA |
| 5 | Kubernetes | TechWorld with Nana | After Docker is solid |

---

## Learn to Cloud vs. Build Your Own X

Use both — but for different things:

- **[Learn to Cloud](https://learntocloud.guide)** — good structural scaffolding for the cloud/infra side (AWS, Terraform, K8s). Tells you *what* to build and in what order, which reduces decision fatigue.
- **[Build Your Own X](https://github.com/codecrafters-io/build-your-own-x)** — better for Python specifically. You're not trying to understand a tool; you're building fluency with a language you already partially know. Building something you understand end-to-end beats typing along with a guided project.

---

## The Rule

> Every skill you learn should produce something that **runs** — a script, a container, a deployed resource. Not notes. Not a certificate of completion. Something that does a thing.

Spend more time in a terminal than watching anything.
