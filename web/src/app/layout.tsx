import "./globals.css";

import type { Metadata } from "next";

import { ThemeProvider } from "@/components/theme/theme-provider"

import { Inter } from "next/font/google"
import { SiteHeader } from "@/components/layout/site-header"

const inter = Inter({ subsets: ["latin"] })

export const metadata: Metadata = {
  title: "SBOM Management System",
  description: "A system for managing Software Bill of Materials",
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body className={inter.className}>
        <ThemeProvider
          attribute="class"
          defaultTheme="system"
          enableSystem
        >
          <div className="relative flex min-h-screen flex-col">
            <SiteHeader />
            <main className="flex-1">{children}</main>
          </div>
        </ThemeProvider>
      </body>
    </html>
  )
}
