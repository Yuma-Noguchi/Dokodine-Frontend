/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  output: "standalone",
  images: {
    loader: 'akamai',
    path: '',
  },
};

export default nextConfig;

