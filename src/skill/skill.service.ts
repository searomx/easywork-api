import { Injectable } from '@nestjs/common';
import { CreateSkillDto } from './dto/create-skill.dto';
import { UpdateSkillDto } from './dto/update-skill.dto';
import { PrismaService } from 'src/db/prisma.service';

@Injectable()
export class SkillService {
  constructor(private readonly prismaService: PrismaService) {
    this.prismaService = prismaService;
  }
  criarSkill(createSkillDto: CreateSkillDto) {
    return this.prismaService.skills.create({
      data: createSkillDto,
      include: {
        user: true,
      },
    });
  }
  buscarTodosSkills() {
    return this.prismaService.skills.findMany();
  }

  buscarUmSkill(id: number) {
    return this.prismaService.skills.findUnique({
      where: { id },
    });
  }

  alterarTodosSkills(id: number, updateSkillDto: UpdateSkillDto) {
    return this.prismaService.skills.updateMany({
      data: updateSkillDto,
      where: { id },
      include: {
        user: true,
      },
    });
  }

  alterarUmSkill(id: number, updateSkillDto: UpdateSkillDto) {
    return this.prismaService.skills.update({
      where: { id },
      data: updateSkillDto,
      include: {
        user: true,
      },
    });
  }

  excluirUmSkill(id: number) {
    return this.prismaService.skills.delete({
      where: { id },
    });
  }
}
