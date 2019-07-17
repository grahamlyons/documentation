---
title: Synthetics APM
kind: documentation
description: APM and Distributed Tracing with Synthetics
aliases:
  - "/synthetics/apm"
further_reading:
  - link: "https://www.datadoghq.com/blog/introducing-synthetic-monitoring/"
    tag: "Blog"
    text: "Introducing Datadog Synthetics"
  - link: "tracing/"
    tag: "Documentation"
    text: "APM and Distributed Tracing"

---

{{< img src="synthetics/apm/synthetics-apm.gif" alt="APM and Synthetics" responsive="true" style="width:80%;">}}

## Overview

The APM integration with Synthetics allows you to go from a test run that potentially failed to the root cause of the issue by looking at the trace generated by that very test run.

Having network-related specifics (thanks to your test) as well as backend, infrastructure, and log information (thanks to your trace) allows you to access a new level of details about the way your application is behaving, as experienced by your user.

## Usage
Statements on this page apply to both [API][1] and [browser tests][2] for APM except where noted.

### Prerequisites

* Your service is [traced on the APM side][3].
* Your service uses an HTTP server.
* Your HTTP server is using a library that supports distributed tracing.

Create a test that hits your traced HTTP server, and Datadog automatically links the trace generated by your server to the corresponding test result.

To link browser test results, whitelist the URLs you want the APM integration headers added to. Use `*` for wildcards:
```text
https://*.datadoghq.com/*
```

## Supported Libraries

The following Datadog tracing libraries are supported:

* [Python][4]
* [Go][5]
* [Java][6]
* [Ruby][7]
* [JavaScript][8]

### How are traces linked to tests?

Datadog uses the distributed tracing protocol and sets up the following HTTP headers:

* `x-datadog-trace-id`, generated from the Synthetics backend. Allows Datadog to link the trace with the test result.
* `x-datadog-parent-id: 0`
* `x-datadog-origin: synthetics`, to make sure the generated traces don't affect your APM quotas. See below.
* `x-datadog-sampling-priority: 1`, [to make sure that the Agent keeps the trace][9].

### How are APM quotas affected?

The `x-datadog-origin: synthetics` header specifies to the APM backend that the traces are Synthetics generated. The generated traces consequently do not impact your classical APM quotas.

### How long are traces retained?

These traces are retained [just like your classical APM traces][10].

## Further Reading

{{< partial name="whats-next/whats-next.html" >}}

[1]: /synthetics/api_tests
[2]: /synthetics/browser_tests
[3]: /tracing
[4]: https://github.com/DataDog/dd-trace-py/releases/tag/v0.22.0
[5]: https://github.com/DataDog/dd-trace-go/releases/tag/v1.10.0
[6]: https://github.com/DataDog/dd-trace-java/releases/tag/v0.24.1
[7]: https://github.com/DataDog/dd-trace-rb/releases/tag/v0.20.0
[8]: https://github.com/DataDog/dd-trace-js/releases/tag/v0.10.0
[9]: https://docs.datadoghq.com/tracing/guide/trace_sampling_and_storage/#how-it-works
[10]: https://docs.datadoghq.com/tracing/guide/trace_sampling_and_storage/#trace-storage