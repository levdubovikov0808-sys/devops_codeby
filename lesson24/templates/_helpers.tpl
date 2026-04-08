{{- define "wordpress.fullname" -}}
{{- .Release.Name }}-{{ .Chart.Name }}
{{- end }}

{{- define "wordpress.labels" -}}
app: {{ include "wordpress.fullname" . }}
release: {{ .Release.Name }}
{{- end }}

{{- define "mysql.fullname" -}}
{{- .Release.Name }}-mysql
{{- end }}
