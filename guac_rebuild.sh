#/bin/bash!

# Tear down and redeploy via podman 
podman-compose -f guacamole-compose.yml down
rm -rf data/ drive/ init/ nginx/ record/
./setup.sh
podman-compose -f guacamole-compose.yml up -d
