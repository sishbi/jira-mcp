FROM gcr.io/distroless/static-debian12:nonroot
ARG TARGETOS
ARG TARGETARCH
COPY ${TARGETOS}/${TARGETARCH}/jira-mcp /jira-mcp
ENTRYPOINT ["/jira-mcp"]
