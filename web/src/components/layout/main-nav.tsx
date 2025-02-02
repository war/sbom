import Link from "next/link"
import { Button } from "@/components/ui/button"

export function MainNav() {
  return (
    <div className="flex items-center space-x-4 lg:space-x-6">
      <Link href="/">
        <Button variant="link">Home</Button>
      </Link>
      <Link href="/sboms">
        <Button variant="link">SBOMs</Button>
      </Link>
      <Link href="/dashboard">
        <Button variant="link">Dashboard</Button>
      </Link>
    </div>
  )
}
