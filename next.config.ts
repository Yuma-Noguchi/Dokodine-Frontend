import type { NextConfig } from 'next';

const nextConfig: NextConfig = {
  reactStrictMode: true,
  output: "standalone",
  images: {
    loader: 'akamai',
    path: '',
  },
};

export default nextConfig;
