{{/* 
Merge the local chart values and the common chart defaults.
*/}}
{{- define "common.values.setup" -}}
  {{- if .Values.commonApp -}}
    {{- $defaultValues := deepCopy .Values.commonApp -}}
    {{- $userValues := deepCopy (omit .Values "commonApp") -}}
    {{- $mergedValues := mustMergeOverwrite $defaultValues $userValues -}}
    {{- $_ := set . "Values" (deepCopy $mergedValues) -}}
  {{- end }}  
{{- end }}
