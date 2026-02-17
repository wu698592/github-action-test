location /github-action-test/ {
    proxy_pass http://github-action-test; #前端默认80，后端要加端口
    include /etc/nginx/conf.d/common/proxy_params.inc;
}