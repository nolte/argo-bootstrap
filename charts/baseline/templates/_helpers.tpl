{{- define "common.labels" -}}
just-mfg.de/application-group: {{ default .dot.Values.applicationGroup .app.applicationGroup }}
{{- end }}