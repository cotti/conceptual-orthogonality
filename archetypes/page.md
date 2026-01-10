---
title: "{{ replace .Name "-" " " | title }}"
description: ""
date: {{ .Date }}
slug: "{{ .Name }}"
# image: ""
# aliases:
#     - /old-page-url

menu:
    main:
        weight: 0
        params:
            icon: file

# outputs:
#     - html
# license: ""
# lastmod: {{ .Date }}
# hidden: false
# comments: false
# toc: true
# math: false

---
