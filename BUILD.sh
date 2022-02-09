# GET LATEST VERSION FROM: https://github.com/ToolJet/ToolJet
VERSION=$(curl -s -XGET https://api.github.com/repos/ToolJet/ToolJet/tags | grep name -m 1 | awk '{print $2}' | cut -d'"' -f2)

# Clone latest version of the repo
rm -rf ./ToolJet
git clone --depth 1 --branch "$VERSION" https://github.com/ToolJet/ToolJet.git

docker buildx build --platform linux/amd64,linux/arm64 \
-t stefangenov/tooljet:latest \
-t stefangenov/tooljet:"${VERSION}" \
-f Dockerfile \
--build-arg TAG_VERSION="${VERSION}" \
--cpu-quota="600000" \
--memory=16g \
--push .
