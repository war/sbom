import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"

export default function Home() {
  return (
    <div className="container py-10">
      <h1 className="text-4xl font-bold mb-6">SBOM Management System</h1>
      
      <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
        <Card>
          <CardHeader>
            <CardTitle>Upload SBOM</CardTitle>
            <CardDescription>Upload and manage your Software Bill of Materials</CardDescription>
          </CardHeader>
          <CardContent>
            <Button>Upload SBOM</Button>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>View SBOMs</CardTitle>
            <CardDescription>Browse and search through your SBOM collection</CardDescription>
          </CardHeader>
          <CardContent>
            <Button variant="secondary">View All</Button>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Dashboard</CardTitle>
            <CardDescription>View analytics and insights</CardDescription>
          </CardHeader>
          <CardContent>
            <Button variant="secondary">Open Dashboard</Button>
          </CardContent>
        </Card>
      </div>
    </div>
  )
}
