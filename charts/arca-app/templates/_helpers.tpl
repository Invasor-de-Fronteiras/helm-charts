{{/*
Expand the name of the chart.
*/}}
{{- define "arca-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "arca-app.fullname" -}}
{{- if .Values.applicationName }}
{{- .Values.applicationName | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "arca-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "arca-app.labels" -}}
helm.sh/chart: {{ include "arca-app.chart" . }}
{{ include "arca-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "arca-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "arca-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "arca-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "arca-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Helper para gerar livenessProbe e readinessProbe.
Se .Values.livenessProbe ou .Values.readinessProbe estiverem definidos, usa-os diretamente.
Caso contrário, gera probes httpGet usando .Values.heatlhcheck.path (fallback "/" se não presente) e porta "http".
Uso: {{ include "arca-app.probes" . | indent 10 }} dentro de um container spec.
*/}}
{{- define "arca-app.probes" -}}
{{- $path := default "/" .Values.heatlhcheck.path -}}
{{- if or .Values.livenessProbe .Values.readinessProbe -}}
  {{- if .Values.livenessProbe }}
livenessProbe:
{{ toYaml .Values.livenessProbe | indent 2 }}
  {{- end }}
  {{- if .Values.readinessProbe }}
readinessProbe:
{{ toYaml .Values.readinessProbe | indent 2 }}
  {{- end }}
{{- else -}}
livenessProbe:
  httpGet:
    path: {{ $path }}
    port: http
  initialDelaySeconds: 10
  periodSeconds: 10
readinessProbe:
  httpGet:
    path: {{ $path }}
    port: http
  initialDelaySeconds: 5
  periodSeconds: 5
{{- end -}}
{{- end }}