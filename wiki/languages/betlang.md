<!--
SPDX-License-Identifier: MPL-2.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->
# betlang

> Probabilistic programming language

**Status:** 📝 Placeholder - contributions welcome

## Overview

betlang is a probabilistic programming language built on Racket, enabling explicit modeling of uncertainty through sampling and inference.

## Core Invariant

**All uncertainty must be explicitly modeled—no hidden randomness.**

## Key Features

- First-class probability distributions
- Bayesian inference primitives
- Conditioning and observation
- Sampling and expectation

## Example

```racket
#lang betlang

; Define a biased coin
(define coin (bernoulli 0.7))

; Model with observation
(define (model)
  (let ([heads (sample coin)])
    (observe (= heads #t))  ; condition on heads
    heads))

; Run inference
(define posterior (infer model 1000))
```

## Use Cases

- Bayesian modeling
- Machine learning prototyping
- Statistical inference
- Uncertainty quantification
- A/B testing analysis

## Getting Started

```bash
cd betlang
racket main.rkt
```

## See Also

- [[Duet Language]] - AI-assisted verification
- [[Ensemble Language]] - AI integration
- [[NEUROSYM.scm]] - Neuro-symbolic patterns
