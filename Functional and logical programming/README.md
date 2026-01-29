
# 🧩 Functional and Logic Programming

This course introduces declarative programming paradigms, which differ fundamentally from imperative languages like C++ or Python. **Prolog** (Logic Programming) for solving constraint-based problems and **Common Lisp** (Functional Programming) for symbolic computation and list processing.

### 📅 Weekly Syllabus

The semester is split into two halves: **Prolog** (Weeks 1-6) and **Lisp** (Weeks 7-12). The final weeks are reserved for assessments.

| Week | 👨‍🏫 Lecture Content | 📝 Seminar (Bi-Weekly) | 💻 Laboratory (Bi-Weekly) |
|:---:|:---|:---|:---|
| **1** | **Prolog Intro:** Facts, Rules, Goals, Unification, Flow model | **S1: Recursion:** Mathematical recursion basics | **L1: Pseudocode:** Recursive algorithms practice |
| **2** | **Prolog Core:** Internal/External goals, Arithmetic, I/O | *--* | *--* |
| **3** | **Backtracking:** The Cut `!`, Fail, Negation, Lists, Recursion | **S2: Lists:** Prolog list processing techniques | **L2: Lists in Prolog:** Implementation & submission |
| **4** | **Structures:** Functors, Heterogeneous lists, Tail recursion | *--* | *--* |
| **5** | **Trees & DB:** Tree traversal, Internal database operations | **S3: Heterogeneous:** Complex list processing | **L3: Trees:** Tree management & List operations |
| **6** | **Advanced:** File management, Deep backtracking | *--* | *--* |
| **7** | **Paradigms:** Imperative vs Declarative. **Lisp Intro** | **S4: Backtracking:** Solving combinatorics in Prolog | **L4: Backtracking:** Combinatorial problems + ❗ **TEST** |
| **8** | **Lisp Basics:** Dynamic data structures, Atoms, Cons cells | *--* | *--* |
| **9** | **Lisp Functions:** `CAR`, `CDR`, Defining functions, Conditional forms | **S5: Lisp Lists:** Processing lists in Lisp | **L5: Lisp Recursion:** Recursive programming tasks |
| **10** | **Symbols:** `OBLIST`, `ALIST`, Destructive functions, Memory | *--* | *--* |
| **11** | **Functional Forms:** `LAMBDA`, `MAP`, `APPLY`, `FUNCALL` | **S6: Maps:** Using Map functions (Functional style) | **L6: Maps:** Advanced Lisp functions |
| **12** | **Macros:** Macro-definitions, Optional arguments | *--* | *--* |
| **13** | **Assessment:** Graded Paper / Final Review | **S7: Recap:** Review of both paradigms | ❗ **L7: PRACTICAL TEST (Lisp)** |
| **14** | **Assessment:** Final Examination | *--* | *--* |

---

### 📚 Key Topics Breakdown

<details>
<summary><strong>Click to expand detailed topic list</strong></summary>

#### Part I: Logic Programming (Prolog)
*   **Declarative Style:** Describing *what* the problem is, not *how* to solve it.
*   **Unification:** The engine matching variables to values automatically.
*   **Backtracking:** The automatic search mechanism that tries alternative solutions when one fails.
*   **The Cut (`!`):** A control mechanism to prune the search tree and prevent backtracking.
*   **Structures:** Trees, Lists, Heterogeneous Lists.

#### Part II: Functional Programming (Common Lisp)
*   **Everything is a List:** The code itself is a list (S-expressions).
*   **Recursion:** The primary method of iteration (loops are rarely used).
*   **Higher Order Functions:** `MAPCAR`, `APPLY`, `FUNCALL` (passing functions as arguments).
*   **Lambda Calculus:** Anonymous functions (`lambda (x) (+ x 1)`).
*   **Cons Cells:** The fundamental building block of memory in Lisp (`head` and `tail`).

</details>

---

### 🛠️ Resources & Tools

*   **SWI-Prolog** - The standard environment for Prolog development.
*   **CLISP / SBCL** - Common Lisp implementations.

---

> *"Lisp involves that kind of beauty where you look at the code and you think, 'God, this is elegant.'"*
