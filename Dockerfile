# Jenkins CI 테스트용 간단한 Nginx 이미지
FROM nginx:alpine

# HTML 파일을 직접 생성
RUN echo "<h1>🚀 Auto Deploy Test - $(date)</h1>" > /usr/share/nginx/html/index.html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
