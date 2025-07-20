docker run -d \
  --name stirling-pdf \
  --restart unless-stopped \
  -p 8085:8080 \
  -v "./StirlingPDF/trainingData:/usr/share/tessdata" \
  -v "./StirlingPDF/extraConfigs:/configs" \
  -v "./StirlingPDF/customFiles:/customFiles/" \
  -v "./StirlingPDF/logs:/logs/" \
  -v "./StirlingPDF/pipeline:/pipeline/" \
  -e DOCKER_ENABLE_SECURITY=false \
  -e LANGS=en_GB \
  docker.stirlingpdf.com/stirlingtools/stirling-pdf:latest
