import { MainNav } from "@/components/layout/main-nav"
import { ThemeToggle } from "@/components/theme/theme-toggle"

export function SiteHeader() {
    return (
      <header className="sticky top-0 z-40 w-full border-b bg-background">
        <div className="container mx-auto px-4 flex h-16 items-center justify-between">
          <MainNav />
          <div className="flex items-center space-x-4">
            <ThemeToggle />
          </div>
        </div>
      </header>
    )
  }
