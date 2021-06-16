
{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "app.id" -}}
{{- if .Values.id }}
{{- .Values.id | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name }}
{{- end }}
{{- end }}

{{/*
namespace
*/}}
{{- define "kafka-operator-helm.namespace" -}}
{{- include "app.id" . -}}
{{- end }}

{{/*
serviceAccountName
*/}}
{{- define "kafka-operator-helm.serviceAccountName" -}}
{{- include "app.id" . -}}-acc
{{- end }}

{{/*
rolename
*/}}
{{- define "kafka-operator-helm.rolename" -}}
{{- include "app.id" . -}}
{{- end }}

{{/*
rolebindingname
*/}}
{{- define "kafka-operator-helm.rolebindingname" -}}
{{- include "app.id" . -}}
{{- end }}

{{/*
configmapNameAccess
*/}}
{{- define "kafka-operator-helm.configmapNameAccess" -}}
{{- include "app.id" . -}} -access
{{- end }}

{{/*
operatorName
*/}}
{{- define "kafka-operator-helm.operatorName" -}}
{{- include "app.id" . -}}
{{- end }}

{{/*
volumeNameAccess
*/}}
{{- define "kafka-operator-helm.volumeNameAccess" -}}
{{- include "app.id" . -}} -access
{{- end }}
