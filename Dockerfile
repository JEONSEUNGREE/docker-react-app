FROM node:alpine as builder
# as를 붙인 이유는 다음 FROM 절이 나오기전까지 builder stage라는 의미이다.
WORKDIR /usr/src/app

COPY package.json ./

RUN npm install

COPY ./ ./

RUN npm run build

FROM nginx

COPY --from=builder /usr/src/app/build /usr/share/nginx/html
# 현재 nginx가 실행할 파일은 builder stage부분에 디렉토리에서 특정 디렉토리로 파일을 복사한다는 뜻이다.

